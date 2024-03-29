#include "frechet_light.h"

#include "defs.h"
#include "filter.h"
#include "times.h"

#include <algorithm>

void FrechetLight::certSetValues(
	CInterval& interval, CInterval const& parent, PointID point_id, CurveID curve_id)
{
#ifdef CERTIFY
	interval.reach_parent = &parent;
	interval.fixed = CPoint(point_id, 0.);
	interval.fixed_curve = curve_id;
#endif
}

void FrechetLight::certAddEmpty(CPoint begin, CPoint end, CPoint fixed_point, CurveID fixed_curve) {
#ifdef CERTIFY
	assert(begin >= 0);
	assert(end <= curve_pair[1-fixed_curve]->size() - 1);
	assert(begin <= end);

	empty_intervals.emplace_back(begin, end);
	empty_intervals.back().fixed = fixed_point;
	empty_intervals.back().fixed_curve = fixed_curve;

	assert(empty_intervals.back().begin >= 0);
	assert(empty_intervals.back().end <= curve_pair[1-empty_intervals.back().fixed_curve]->size() - 1);
#endif
}

void FrechetLight::certAddNonfreeParts(const CInterval& outer, PointID min, PointID max, PointID fixed_point, CurveID fixed_curve) {
#ifdef CERTIFY
	if (outer.is_empty()) {
		certAddEmpty(CPoint(min,0.), CPoint(max,0.), CPoint(fixed_point,0.), fixed_curve);
	} else {
		CPoint safebegin = outer.begin; 
		CPoint safeend = outer.end;
		// [min, safebegin] is completely empty if safebegin > min
		// [safeend, max] is completely empty if max > safeend
		assert(safebegin >= min and safebegin <= max);
		assert(safeend >= min and safeend <= max);
		if (safebegin > min) {
			certAddEmpty(CPoint(min,0.), safebegin, CPoint(fixed_point,0.), fixed_curve); 
		}
		if (safeend < max) {
			certAddEmpty(safeend, CPoint(max,0.), CPoint(fixed_point,0.), fixed_curve); 
		}
	}
#endif
}

void FrechetLight::visAddReachable(CInterval const& cinterval)
{
#ifdef VIS
    if (cinterval.is_empty()) { return; }
	reachable_intervals.push_back(cinterval);
#endif
}

void FrechetLight::visAddUnknown(CPoint begin, CPoint end, CPoint fixed_point, CurveID fixed_curve) {
#ifdef VIS
	if (begin >= end) { return; }

	assert(begin >= 0);
	assert(end <= curve_pair[1-fixed_curve]->size() - 1);

	unknown_intervals.emplace_back(begin, end);
	unknown_intervals.back().fixed = fixed_point;
	unknown_intervals.back().fixed_curve = fixed_curve;

	assert(unknown_intervals.back().begin >= 0);
	assert(unknown_intervals.back().end <= curve_pair[1-unknown_intervals.back().fixed_curve]->size() - 1);
#endif
}

void FrechetLight::visAddConnection(CPoint begin, CPoint end, CPoint fixed_point, CurveID fixed_curve)
{
#ifdef VIS
	if (begin >= end) { return; }

	assert(begin >= 0);
	assert(end <= curve_pair[1-fixed_curve]->size() - 1);

	connections.emplace_back(begin, end);
	connections.back().fixed = fixed_point;
	connections.back().fixed_curve = fixed_curve;

	assert(connections.back().begin >= 0);
	assert(connections.back().end <= curve_pair[1-connections.back().fixed_curve]->size() - 1);
#endif
}

void FrechetLight::visAddFreeNonReachable(CPoint begin, CPoint end, CPoint fixed_point, CurveID fixed_curve) {
#ifdef VIS
	if (begin >= end) { return; }

	assert(begin >= 0);
	assert(end <= curve_pair[1-fixed_curve]->size() - 1);

	free_non_reachable.emplace_back(begin, end);
	free_non_reachable.back().fixed = fixed_point;
	free_non_reachable.back().fixed_curve = fixed_curve;

	assert(free_non_reachable.back().begin >= 0);
	assert(free_non_reachable.back().end <= curve_pair[1-free_non_reachable.back().fixed_curve]->size() - 1);
#endif
}

inline CInterval FrechetLight::getInterval(Point const& point, Curve const& curve, PointID i) const
{
	return getInterval(point, curve, i, nullptr);
}

inline CInterval FrechetLight::getInterval(Point const& point, Curve const& curve, PointID i, CInterval* outer) const
{
    Interval outer_temp;
    Interval* outer_pt = outer == nullptr ? nullptr : &outer_temp;
    auto interval = IntersectionAlgorithm::intersection_interval(point, distance, curve[i], curve[i + 1], outer_pt);

    if (outer != nullptr) {
		//TODO change intersection_interval so that the outer interval is
		// 0,1 instead of -eps, 1+eps ?
		*outer = CInterval{i, std::max(outer_temp.begin,0.), i, std::min(outer_temp.end,1.)};
    }
    return CInterval{i, interval.begin, i, interval.end};
}

inline void FrechetLight::merge(CIntervals& intervals, CInterval const& new_interval) const
{
	if (new_interval.is_empty()) { return; }

	if (!intervals.empty() && new_interval.begin == intervals.back().end) {
		intervals.back().end = new_interval.end;
	}
	else {
		intervals.emplace_back(new_interval);
	}
}

inline QSimpleInterval FrechetLight::getFreshQSimpleInterval(Point const& fixed_point, PointID min, PointID max, const Curve& curve) const
{
	QSimpleInterval qsimple;
	updateQSimpleInterval(qsimple, fixed_point, min, max, curve);
	return qsimple;
}


inline bool FrechetLight::updateQSimpleInterval(QSimpleInterval& qsimple, Point const& fixed_point, PointID min, PointID max, const Curve& curve) const
{
	assert( (qsimple.getFreeInterval().is_empty() and qsimple.getOuterInterval().is_empty()) or (!qsimple.getFreeInterval().is_empty() and !qsimple.getOuterInterval().is_empty()));
	if (qsimple.is_valid() or (qsimple.hasPartialInformation() and qsimple.getLastValidPoint() >= max)) {
		qsimple.validate();
		qsimple.clamp(CPoint{min,0.},CPoint{max,0.});
		return false; //parent information already valid
	} 


	if (qsimple.hasPartialInformation()) {
	       if (qsimple.getLastValidPoint() < min) {
		       qsimple = QSimpleInterval(); //we know nothing about this part
	       } else  {
		       qsimple.clamp(CPoint{min,0.}, CPoint{max,0.}); 
		       if (!qsimple.getFreeInterval().is_empty()) {
			       return false; //even restricted to current interval, parent information still gives invalidity 
		       }
	       }
	} 
	
	//from here on, need to compute new information
	global::times.startCountingFreeTests();

	if (!qsimple.hasPartialInformation()) { //fresh computation, start with heuristics
		// heuristic check:
		auto mid = (min + max)/2;
		auto maxdist = std::max(curve.curve_length(min, mid), curve.curve_length(mid, max));
		auto mid_dist_sqr = fixed_point.dist_sqr(curve[mid]);

		//heuristic tests avoiding sqrts
		auto comp_dist1 = distance - maxdist;
		auto comp_dist2 = distance + maxdist;
		if ((comp_dist1 > 0 && mid_dist_sqr <= std::pow(comp_dist1, 2))) {
			qsimple.setFreeInterval(min, max); //full
			qsimple.setOuterInterval(min, max);
			qsimple.validate();

			global::times.incrementFreeTests(max - min); 
			global::times.stopCountingFreeTests();

			return true;
		} else if (mid_dist_sqr > std::pow(comp_dist2, 2)) {
			qsimple.setFreeInterval(max, min); //empty
			qsimple.setOuterInterval(max, min);
			qsimple.validate();

			global::times.incrementFreeTests(max - min); 
			global::times.stopCountingFreeTests();

			return true;
		}
	}

	continueQSimpleSearch(qsimple, fixed_point, min, max, curve);

	assert( (qsimple.getFreeInterval().is_empty() and qsimple.getOuterInterval().is_empty()) or (!qsimple.getFreeInterval().is_empty() and !qsimple.getOuterInterval().is_empty()));
	return true;
}


inline void FrechetLight::continueQSimpleSearch(QSimpleInterval& qsimple, Point const& fixed_point, PointID min, PointID max, const Curve& curve) const
{
	assert(!qsimple.hasPartialInformation() or (qsimple.getLastValidPoint() >= min and qsimple.getLastValidPoint() <= max));

	PointID start;
	if (qsimple.hasPartialInformation()) {
		start = qsimple.getLastValidPoint();
	} else {
		start = min;
	}

	//Logical assert: there should be no free point in [min, start):
	// if start > min, then the free interval must be empty

	bool current_free = fixed_point.dist_sqr(curve[start]) <= dist_sqr;
	// Work directly on the simple_interval of the boundary
	//CPoint first_free = current_free ? CPoint{min,0.} : CPoint{max+1,0.};
	assert((not current_free) or start==min);
	CPoint first_free = current_free ? CPoint{min,0.} : CPoint{max+1, 0.}; //qsimple.free.begin;

	//CERT: outerinterval -- note that it is safe to set last_empty=min even if min is free,
	//since we never add an empty interval of a single point
	//TODO do we need to make sure that last_empty etc. is used only if we want to certify or does the compiler optimization take care of it?
	CPoint last_empty = current_free ? CPoint{min, 0.} : CPoint{max+1,0.};

	assert(first_free > max || fixed_point.dist_sqr(curve.interpolate_at(first_free)) <= dist_sqr);
	
	std::size_t stepsize = static_cast<std::size_t>(max - start)/2;
	if (stepsize < 1 or qsimple.hasPartialInformation()) {
		stepsize = 1;
	}
	for (PointID cur = start; cur < max; ) {
		// heuristic steps:
		
		stepsize = std::min<std::size_t>(stepsize, max - cur);
		auto mid = cur + (stepsize+1)/2; 
		auto maxdist = std::max(curve.curve_length(cur, mid), curve.curve_length(mid, cur + stepsize));
		auto mid_dist_sqr = fixed_point.dist_sqr(curve[mid]);

		auto comp_dist1 = distance - maxdist;
		if (current_free && comp_dist1 > 0 && mid_dist_sqr <= std::pow(comp_dist1, 2)) {
			cur += stepsize;
			
			global::times.incrementFreeTests(stepsize);
			
			stepsize *= 2;
			continue;
		}
		auto comp_dist2 = distance + maxdist;
		if (!current_free && mid_dist_sqr > std::pow(comp_dist2, 2)) {
			cur += stepsize;
			
			global::times.incrementFreeTests(stepsize);
			
			stepsize *= 2;
			continue;
		}
		// if heuristic steps don't work, then reduce stepsize:
		if (stepsize > 1) {
			stepsize /= 2;
			
			global::times.incrementFreeTests(0);
			
			continue;
		}
		
		// from here on stepsize == 1:
		// mid == end holds in this case
		auto const& end_point = curve[mid];
		auto end_dist_sqr = mid_dist_sqr;
		// if last and next point are both free:
		if (current_free && (end_dist_sqr <= dist_sqr)) {
			++cur;
			stepsize *= 2;
			
			global::times.incrementFreeTests(1);
			
			continue;
		}
		
		// otherwise we have to compute the intersection interval:
		auto const& cur_point = curve[cur];
		Interval outer;
		auto interval = IntersectionAlgorithm::intersection_interval(fixed_point, distance, cur_point, end_point, &outer);
		outer.begin = std::max(outer.begin, 0.);
		outer.end = std::min(outer.end, 1.);
		if (interval.is_empty()) {
			++cur;
			stepsize *= 2;
			
			global::times.incrementFreeTests(1);
			
			continue;
		}
		// from here on the intersection interval is non-trivial:
		if (!current_free) {
			if (qsimple.is_valid()) { //we encountered a second free interval -> not qsimple
				qsimple.invalidate();
				// still store information in qsimple interval for future use
				qsimple.setLastValidPoint(cur);

			
				global::times.incrementFreeTests(0);
				global::times.stopCountingFreeTests();
				
				return;
			}
			
			// if two changes in current interval:
			if (interval.begin != 0 && interval.end != 1) {
				qsimple.setFreeInterval(CPoint{cur, interval.begin}, CPoint{cur, interval.end});
				qsimple.setOuterInterval(CPoint{cur, outer.begin}, CPoint{cur, outer.end});
				qsimple.validate();
			} 
			else {  // if one change in current interval:
				first_free = CPoint{cur, interval.begin};
				last_empty = CPoint{cur, outer.begin};
				current_free = true;
			}
			
			++cur;
			
			global::times.incrementFreeTests(1);
		} 
		else { 
			assert(interval.begin == 0); // current_free holds 
			assert(interval.end != 1); // end_dist_sqr <= dist_sqr does not hold, otherwise we would have stopped before
			
			qsimple.setFreeInterval(first_free, CPoint{cur, interval.end});
			qsimple.setOuterInterval(last_empty, CPoint{cur, outer.end});
			qsimple.validate();
			current_free = false;
			++cur;
			
			global::times.incrementFreeTests(1);
		}
	}
	
	global::times.stopCountingFreeTests();
	
	// If it is still invalid but we didn't return yet, then the free interval ends at max
	// Note: if no free points were found, first_free defaults to an invalid value (>> max), making the interval empty   
	if (! qsimple.is_valid()) {
		qsimple.setFreeInterval(first_free, CPoint{max,0.});
		qsimple.setOuterInterval(last_empty, CPoint{max,0.});
		qsimple.validate();
	}
	
	return;
}

CIntervals::iterator getIntervalContainingNumber(const CIntervals::iterator& begin, const CIntervals::iterator& end, CPoint const& x) {
	auto it = std::upper_bound(begin, end, CInterval{x, CPoint{std::numeric_limits<PointID::IDType>::max(),0.}});
	if (it != begin) {
		--it;
		if (it->begin <= x && it->end >= x) {
			return it;
		}
	}
	return end;
}

CIntervals::iterator getIntervalContainingNumber(const CIntervals::iterator& begin, const CIntervals::iterator& end, PointID x) {
	auto it = std::upper_bound(begin, end, CInterval{x, 0., std::numeric_limits<PointID::IDType>::max(), 0.});
	if (it != begin) {
		--it;
		if (it->begin <= x && it->end >= x) {
			return it;
		}
	}
	return end;
}

void FrechetLight::getReachableIntervals(BoxData& data)
{
	++num_boxes;

	auto const& box = data.box;
	auto const& inputs = data.inputs;
	CInterval const empty;

	global::times.newSplit();

	assert(box.max1 > box.min1 && box.max2 > box.min2);
//	assert(outputs.id1.valid() || outputs.id2.valid());

	firstinterval1 = (inputs.begin1 != inputs.end1) ? &*inputs.begin1 : &empty;
	firstinterval2 = (inputs.begin2 != inputs.end2) ? &*inputs.begin2 : &empty;

	if (emptyInputsRule(data)) { return; }

	min1_frac = 0., min2_frac = 0.;
	boxShrinkingRule(data);

	if (box.isCell()) {
		visAddCell(box);
		handleCellCase(data);
		return;
	}
	else {
		getQSimpleIntervals(data);
		calculateQSimple1(data);
		calculateQSimple2(data);

		if (out1_valid && out2_valid) { return; }
		if (boundaryPruningRule(data)) { return; }

		assert(box.max1 >= box.min1 + 2 || box.max2 >= box.min2 + 2);
		assert(box.max1 >= box.min1 && box.max2 >= box.min2);

		splitAndRecurse(data);
	}
}

inline bool FrechetLight::emptyInputsRule(BoxData& data)
{
	auto const& box = data.box;

	// empty input intervals -> empty output intervals
	// Note: if we are currently handling a cell then even if we are not pruning,
	// we have to return with empty outputs for the subsequent code to work.
	if (pruning_level > 0 || (box.min1 == box.max1 - 1 && box.min2 == box.max2 - 1)) {
		if (firstinterval2->is_empty() && firstinterval1->is_empty()) {
			if (data.outputs.id2.valid()) {
				visAddUnknown(CPoint(box.min2,0.), CPoint(box.max2,0.), CPoint(box.max1,0.), 0);
			}
			if (data.outputs.id1.valid()) {
				visAddUnknown(CPoint(box.min1,0.), CPoint(box.max1,0.), CPoint(box.max2,0.), 1);
			}
			return true;
		}
	}

	return false;
}

inline void FrechetLight::boxShrinkingRule(BoxData& data)
{
	auto& box = data.box;

	// "movement of input boundary" if one of the inputs is empty
	if (pruning_level > 1 && enable_box_shrinking) {
		if (firstinterval2->is_empty() && firstinterval1->begin > box.min1) {
			auto old_min1 = box.min1;

			min1_frac = firstinterval1->begin.getFraction();
			box.min1 = firstinterval1->begin.getPoint();
			assert(box.min1 <= box.max1);
			if (box.min1 == box.max1) {
				box.min1 = box.max1 - 1;
				min1_frac = 1.;
			}

			if (box.min1 != old_min1) {
				visAddUnknown(CPoint(box.min2,0.), CPoint(box.max2,0.), CPoint(box.min1,0.), 0);
				if (data.outputs.id1.valid()) {
					visAddUnknown(CPoint(old_min1,0.), CPoint(box.min1,0.), CPoint(box.max2,0.), 1);
				}
			}
		}
		else if (firstinterval1->is_empty() && firstinterval2->begin > box.min2) {
			auto old_min2 = box.min2;

			min2_frac = firstinterval2->begin.getFraction();
			box.min2 = firstinterval2->begin.getPoint();
			assert(box.min2 <= box.max2);
			if (box.min2 == box.max2) {
				box.min2 = box.max2 - 1;
				min2_frac = 1.;
			}

			if (box.min2 != old_min2) {
				visAddUnknown(CPoint(box.min1,0.), CPoint(box.max1,0.), CPoint(box.min2,0.), 1);
				if (data.outputs.id2.valid()) {
					visAddUnknown(CPoint(old_min2,0.), CPoint(box.min2,0.), CPoint(box.max1,0.), 0);
				}
			}
		}
	}
}

inline void FrechetLight::handleCellCase(BoxData& data)
{
	auto const& curve1 = *curve_pair[0];
	auto const& curve2 = *curve_pair[1];
	auto const& box = data.box;

	if (data.outputs.id1.valid()) {
		CInterval outer1;
		//TODO set &outer1 to nullptr if we don't certify? Probably not really costly...
		CInterval output1 = getInterval(curve2[box.max2], curve1, box.min1, &outer1);
		certAddNonfreeParts(outer1, box.min1, box.max1, box.max2, 1);
		if (firstinterval2->is_empty()) {
			visAddFreeNonReachable(
				output1.begin, std::min(output1.end, firstinterval1->begin), {box.max2,0.}, 1);
			output1.begin.setFraction(
				std::max(output1.begin.getFraction(), firstinterval1->begin.getFraction()));
			certSetValues(output1, *firstinterval1, box.max2, 1);
		}
		else {
			certSetValues(output1, *firstinterval2, box.max2, 1);
		}
		merge(reachable_intervals_vec[data.outputs.id1], output1);
		visAddReachable(output1);
	}

	if (data.outputs.id2.valid()) {
		CInterval outer2;
		CInterval output2 = getInterval(curve1[box.max1], curve2, box.min2, &outer2);
		certAddNonfreeParts(outer2, box.min2, box.max2, box.max1, 0);
		if (firstinterval1->is_empty()) {
			visAddFreeNonReachable(
				output2.begin, std::min(output2.end, firstinterval2->begin), {box.max1,0.}, 0);
			output2.begin.setFraction(
				std::max(output2.begin.getFraction(), firstinterval2->begin.getFraction()));
			certSetValues(output2, *firstinterval2, box.max1, 0);
		}
		else {
			certSetValues(output2, *firstinterval1, box.max1, 0);
		}
		merge(reachable_intervals_vec[data.outputs.id2], output2);
		visAddReachable(output2);
	}
}

inline void FrechetLight::getQSimpleIntervals(BoxData& data)
{
	auto const& curve1 = *curve_pair[0];
	auto const& curve2 = *curve_pair[1];
	auto const& box = data.box;

	qsimple1.invalidate();
	qsimple2.invalidate();

	// Get qsimple intervals. Different cases depending on what has been calculated yet.
	if (data.outputs.id1.valid()) {
		if (data.qsimple_outputs.id1.valid()) {
			qsimple1 = qsimple_intervals[data.qsimple_outputs.id1];
		} else {
			qsimple1 = QSimpleInterval();
		}
		bool changed = updateQSimpleInterval(qsimple1, curve2[box.max2], box.min1, box.max1, curve1);
		if (changed) {
			qsimple_intervals.push_back(qsimple1);
			data.qsimple_outputs.id1 = qsimple_intervals.size() - 1;
		}
	}
	if (data.outputs.id2.valid()) {
		if (data.qsimple_outputs.id2.valid()) {
			qsimple2 = qsimple_intervals[data.qsimple_outputs.id2];
		} else {
			qsimple2 = QSimpleInterval();
		}
		bool changed = updateQSimpleInterval(qsimple2, curve1[box.max1], box.min2, box.max2, curve2);
		if (changed) {
			qsimple_intervals.push_back(qsimple2);
			data.qsimple_outputs.id2 = qsimple_intervals.size()-1;
		}
	}
}

inline void FrechetLight::calculateQSimple1(BoxData& data)
{
	auto const& curve1 = *curve_pair[0];
	auto const& curve2 = *curve_pair[1];
	auto const& box = data.box;

	out1_valid = false;
	out1.make_empty();

	// pruning rules depending on qsimple1
	if (qsimple1.is_valid()) {
		// output boundary is empty
		if (qsimple1.is_empty()) {
			// out1 is already empty due to initialization, so leave it.
			if (pruning_level > 2 && enable_empty_outputs) {
				out1_valid = true;
			}
		}
		else {
			CPoint x = (qsimple1.getFreeInterval().begin > CPoint{box.min1,min1_frac}) ? 
									  qsimple1.getFreeInterval().begin : CPoint{box.min1,min1_frac};
			// check if beginning is reachable
			if (x == box.min1 && pruning_level > 3 && enable_propagation1) {
				auto it = getIntervalContainingNumber(data.inputs.begin2, data.inputs.end2, box.max2);
				if (it != data.inputs.end2) { //(box.min1, box.max2) is reachable from interval *it 
					CInterval &parent = *it; 
					out1 = qsimple1.getFreeInterval();
					out1_valid = true;
					certSetValues(out1, parent, box.max2, 1);
				}
			}
			// check if nothing can be reachable
			if (x != box.min1 && x > qsimple1.getFreeInterval().end && pruning_level > 4 && enable_propagation2) {
				// out1 is already empty due to initialization, so leave it.
				out1_valid = true;
			}
			// check if we can propagate reachability through the box to the beginning
			// of the free interval
			else if (x > box.min1 && pruning_level > 4 && enable_propagation2) {
				auto it = getIntervalContainingNumber(data.inputs.begin1, data.inputs.end1, x);
				if (it != data.inputs.end1) { //(x, box.min2) is reachable from interval *it 
					auto interval = getFreshQSimpleInterval(curve1.interpolate_at(x), box.min2, box.max2, curve2);
					if (interval.is_valid()) {
						CInterval &parent = *it; 
						out1 = qsimple1.getFreeInterval();
						out1.begin = x;
						out1_valid = true;
						certSetValues(out1, parent, box.max2, 1);
						visAddConnection({box.min2,0.}, {box.max2,0.}, x, 0);
					}
				}
			}
		}
	}
	if (out1_valid) {
		merge(reachable_intervals_vec[data.outputs.id1], out1);
		visAddReachable(out1);
		certAddNonfreeParts(qsimple1.getOuterInterval(), box.min1, box.max1, box.max2, 1);
		if (!out1.is_empty()) {
			visAddFreeNonReachable(qsimple1.getFreeInterval().begin, out1.begin, {box.max2,0.}, 1);
		}
		data.outputs.id1.invalidate();
	}
	out1_valid = !data.outputs.id1.valid();
}

inline void FrechetLight::calculateQSimple2(BoxData& data)
{
	auto const& curve1 = *curve_pair[0];
	auto const& curve2 = *curve_pair[1];
	auto const& box = data.box;

	out2_valid = false;
	out2.make_empty();

	// pruning rules depending on qsimple2
	if (qsimple2.is_valid()) {
		// output boundary is empty
		if (qsimple2.is_empty()) {
			// out2 is already empty due to initialization, so leave it.
			if (pruning_level > 2 && enable_empty_outputs) {
				out2_valid = true;
			}
		}
		else {
			CPoint x = (qsimple2.getFreeInterval().begin > CPoint{box.min2, min2_frac}) ? 
									  qsimple2.getFreeInterval().begin : CPoint{box.min2, min2_frac};
			// check if beginning is reachable
			if (x == box.min2 && pruning_level > 3 && enable_propagation1) {
				auto it = getIntervalContainingNumber(data.inputs.begin1, data.inputs.end1, box.max1);
				if (it != data.inputs.end1) {
					CInterval &parent = *it; 
					out2 = qsimple2.getFreeInterval();
					out2_valid = true;
					certSetValues(out2, parent, box.max1, 0);
				}
			}
			// check if nothing can be reachable
			if (x != box.min2 && x > qsimple2.getFreeInterval().end && pruning_level > 4 && enable_propagation2) {
				// out2 is already empty due to initialization, so leave it.
				out2_valid = true;
			}
			// check if we can propagate reachability through the box to the beginning
			// of the free interval
			else if (x > box.min2 && pruning_level > 4 && enable_propagation2) {
				auto it = getIntervalContainingNumber(data.inputs.begin2, data.inputs.end2, x);
				if (it != data.inputs.end2) {
					auto interval = getFreshQSimpleInterval(curve2.interpolate_at(x), box.min1, box.max1, curve1);
					if (interval.is_valid()) {
						CInterval &parent = *it; 
						out2 = qsimple2.getFreeInterval();
						out2.begin = x;
						out2_valid = true;
						certSetValues(out2, parent, box.max1,0);
						visAddConnection({box.min1,0.}, {box.max1,0.}, x, 1);
					}
				}
			}
		}
	}
	if (out2_valid) {
		merge(reachable_intervals_vec[data.outputs.id2], out2);
		visAddReachable(out2);
		certAddNonfreeParts(qsimple2.getOuterInterval(), box.min2, box.max2, box.max1, 0);
		if (!out2.is_empty()) {
			visAddFreeNonReachable(qsimple2.getFreeInterval().begin, out2.begin, {box.max1,0.}, 0);
		}
		data.outputs.id2.invalidate();
	}
	out2_valid = !data.outputs.id2.valid();
}

inline bool FrechetLight::boundaryPruningRule(BoxData& data)
{
	auto const& curve1 = *curve_pair[0];
	auto const& curve2 = *curve_pair[1];
	auto const& box = data.box;

	// special cases for boxes which are at the boundary of the freespace diagram
	if (pruning_level > 5 && enable_boundary_rule) {
		if (box.max1 == curve1.size()-1 && out1_valid) {
			visAddUnknown({box.min2,0.}, {box.max2,0.}, {box.max1,0.}, 0);
			return true;
		}
		if (box.max2 == curve2.size()-1 && out2_valid) {
			visAddUnknown({box.min1,0.}, {box.max1,0.}, {box.max2,0.}, 1);
			return true;
		}
	}

	return false;
}

inline void FrechetLight::splitAndRecurse(BoxData& data)
{
	auto const& box = data.box;

	if (box.max2 - box.min2 > box.max1 - box.min1) { // horizontal split
		reachable_intervals_vec.emplace_back();
		CIntervalsID inputs1_middleID = reachable_intervals_vec.size()-1;

		PointID split_position = (box.max2 + box.min2) / 2;
		assert(split_position > box.min2 && split_position < box.max2);

		auto bound = CInterval{split_position, 0., std::numeric_limits<PointID::IDType>::max(),0.};
		auto it = std::upper_bound(data.inputs.begin2, data.inputs.end2, bound);

		BoxData data_bottom{
			{box.min1, box.max1, box.min2, split_position},
			{data.inputs.begin1, data.inputs.end1, data.inputs.begin2, it},
			{inputs1_middleID, data.outputs.id2},
			{QSimpleID(), data.qsimple_outputs.id2}
		};
		getReachableIntervals(data_bottom);

		if (it != data.inputs.begin2 && (it-1)->end >= split_position) { --it; }
		CIntervals& inputs1_middle = reachable_intervals_vec[inputs1_middleID];

		BoxData data_top{
			{box.min1, box.max1, split_position, box.max2},
			{inputs1_middle.begin(), inputs1_middle.end(), it, data.inputs.end2},
			{data.outputs.id1, data.outputs.id2},
			{data.qsimple_outputs.id1, data.qsimple_outputs.id2}
		};
		getReachableIntervals(data_top);
	} else { // vertical split
		reachable_intervals_vec.emplace_back();
		CIntervalsID inputs2_middleID = reachable_intervals_vec.size()-1;

		PointID split_position = (box.max1 + box.min1) / 2;
		assert(split_position > box.min1 && split_position < box.max1);

		auto bound = CInterval{split_position, 0., std::numeric_limits<PointID::IDType>::max(), 0.};
		auto it = std::upper_bound(data.inputs.begin1, data.inputs.end1, bound);

		BoxData data_left{
			{box.min1, split_position, box.min2, box.max2},
			{data.inputs.begin1, it, data.inputs.begin2, data.inputs.end2},
			{data.outputs.id1, inputs2_middleID},
			{data.qsimple_outputs.id1, QSimpleID()}
		};
		getReachableIntervals(data_left);

		if (it != data.inputs.begin1 && (it-1)->end >= split_position) { --it; }
		CIntervals& inputs2_middle = reachable_intervals_vec[inputs2_middleID];

		BoxData data_right{
			{split_position, box.max1, box.min2, box.max2},
			{it, data.inputs.end1, inputs2_middle.begin(), inputs2_middle.end()},
			{data.outputs.id1, data.outputs.id2},
			{data.qsimple_outputs.id1, data.qsimple_outputs.id2}
		};
		getReachableIntervals(data_right);
	}
}

CPoint FrechetLight::getLastReachablePoint(Point const& point, Curve const& curve) const
{
	PointID max = curve.size()-1;
	std::size_t stepsize = 1;
	for (PointID cur = 0; cur < max; ) {
		// heuristic steps:
		stepsize = std::min<std::size_t>(stepsize, max - cur);

		auto mid = cur + (stepsize+1)/2; 
		auto first_part = curve.curve_length(cur+1, mid);
		auto second_part = curve.curve_length(mid, cur + stepsize);
		auto maxdist = std::max(first_part, second_part);
		auto mid_dist_sqr = point.dist_sqr(curve[mid]);

		auto comp_dist1 = distance - maxdist;
		if (comp_dist1 > 0 && mid_dist_sqr <= std::pow(comp_dist1, 2)) {
			cur += stepsize;
			stepsize *= 2;
		}
		// if heuristic steps don't work, then reduce stepsize:
		else if (stepsize > 1) {
			stepsize /= 2;
		}
		else { 
			// stepsize = 1 and heuristic step didn't work
			// then it follows that the last reachable point is on the current interval
			return getInterval(point, curve, cur).end;
		}
	}
	return CPoint{max, 0.};
}

void FrechetLight::buildFreespaceDiagram(distance_t distance, Curve const& curve1, Curve const& curve2)
{
	this->curve_pair[0] = &curve1;
	this->curve_pair[1] = &curve2;
	this->distance = distance;
	this->dist_sqr = distance * distance;

	clear();

	Box initial_box(0, curve1.size()-1, 0, curve2.size()-1);
	Inputs initial_inputs = computeInitialInputs();
	Outputs final_outputs = createFinalOutputs();

	initCertificate(initial_inputs);

	// this is the main computation of the decision problem
	computeOutputs(initial_box, initial_inputs, final_outputs);
}

bool FrechetLight::lessThan(distance_t distance, Curve const& curve1, Curve const& curve2)
{
	this->curve_pair[0] = &curve1;
	this->curve_pair[1] = &curve2;
	this->distance = distance;
	this->dist_sqr = distance * distance;

	// curves empty or start or end are already far
	if (curve1.empty() || curve2.empty()) { return false; }
	if (curve1.front().dist_sqr(curve2.front()) > dist_sqr) { return false; }
	if (curve1.back().dist_sqr(curve2.back()) > dist_sqr) { return false; }

	// cases where at least one curve has length 1
	if (curve1.size() == 1 && curve2.size() == 1) { return true; }
	if (curve1.size() == 1) { return isClose(curve1.front(), curve2); }
	if (curve2.size() == 1) { return isClose(curve2.front(), curve1); }

	clear();

	Box initial_box(0, curve1.size()-1, 0, curve2.size()-1);
	Inputs initial_inputs = computeInitialInputs();
	Outputs final_outputs = createFinalOutputs();

	initCertificate(initial_inputs);

	// this is the main computation of the decision problem
	computeOutputs(initial_box, initial_inputs, final_outputs);

//     stream << "this does not work!" << std::endl;
//     displayOnMATLAB(stream);
    
	return isTopRightReachable(final_outputs);
}

bool FrechetLight::lessThanWithFilters(distance_t distance, Curve const& curve1, Curve const& curve2)
{
	this->curve_pair[0] = &curve1;
	this->curve_pair[1] = &curve2;
	this->distance = distance;
	this->dist_sqr = distance * distance;
    
	assert(curve1.size());
	assert(curve2.size());

	if (curve1[0].dist_sqr(curve2[0]) > dist_sqr ||
		curve1.back().dist_sqr(curve2.back()) > dist_sqr) {
		return false;
	}
	if (curve1.size() == 1 && curve2.size() == 1) {
		return true;
	}


	Filter filter(curve1, curve2, distance);

	if (filter.bichromaticFarthestDistance()) {
		return true;
	}

	PointID pos1;
	PointID pos2;
	if (filter.adaptiveGreedy(pos1, pos2)) {
		return true;
	}
	if (filter.negative(pos1, pos2)) {
		return false;
	}
	if (filter.adaptiveSimultaneousGreedy()) {
		return true;
	}

	++non_filtered;

	return lessThan(distance, curve1, curve2);
}

inline void FrechetLight::computeOutputs(
	Box const& initial_box, Inputs const& initial_inputs, Outputs& final_outputs)
{
	num_boxes = 0;

	BoxData box_data{initial_box, initial_inputs, final_outputs, QSimpleOutputs()};
	getReachableIntervals(box_data);
}

inline void FrechetLight::visAddCell(Box const& box)
{
#ifdef VIS
	cells.emplace_back(box.min1, box.min2);
#endif
}

inline bool FrechetLight::isClose(Point const& point, Curve const& curve) const
{
	return getLastReachablePoint(point, curve) == CPoint{PointID(curve.size()-1), 0.};
}

inline bool FrechetLight::isTopRightReachable(Outputs const& outputs) const
{
	auto const& curve1 = *curve_pair[0];
	auto const& curve2 = *curve_pair[1];
	auto const& outputs1 = reachable_intervals_vec[outputs.id1];
	auto const& outputs2 = reachable_intervals_vec[outputs.id2];

	return (!outputs1.empty() && (outputs1.back().end.getPoint() == curve1.size()-1))
		|| (!outputs2.empty() && (outputs2.back().end.getPoint() == curve2.size()-1));
}

inline void FrechetLight::initCertificate(Inputs const& initial_inputs)
{
#ifdef CERTIFY
	auto const& curve1 = *curve_pair[0];
	auto const& curve2 = *curve_pair[1];

	empty_intervals.clear();

	CInterval origin = CInterval(0,0);
	certSetValues(origin, origin, 0, -1);
	certSetValues(*initial_inputs.begin1, origin, 0, 1);
	certSetValues(*initial_inputs.begin2, origin, 0, 0);

	visAddUnknown(initial_inputs.begin1->end, CPoint(curve1.size()-1,0.), {0,0.}, 1);
	visAddUnknown(initial_inputs.begin2->end, CPoint(curve2.size()-1,0.), {0,0.}, 0);
	visAddReachable(*initial_inputs.begin1);
	visAddReachable(*initial_inputs.begin2);
#endif
}

inline auto FrechetLight::createFinalOutputs() -> Outputs
{
	Outputs outputs;

	reachable_intervals_vec.emplace_back();
	outputs.id1 = reachable_intervals_vec.size()-1;
	reachable_intervals_vec.emplace_back();
	outputs.id2 = reachable_intervals_vec.size()-1;

	return outputs;
}

// this function assumes that the start points of the two curves are close
inline auto FrechetLight::computeInitialInputs() -> Inputs
{
	Inputs inputs;

	auto const& curve1 = *curve_pair[0];
	auto const& curve2 = *curve_pair[1];

	auto const first = CPoint(0,0.);

	auto last1 = getLastReachablePoint(curve2.front(), curve1);
	reachable_intervals_vec.emplace_back();
	reachable_intervals_vec.back().emplace_back(first, last1);
	inputs.begin1 = reachable_intervals_vec.back().begin();
	inputs.end1 = reachable_intervals_vec.back().end();

	auto last2 = getLastReachablePoint(curve1.front(), curve2);
	reachable_intervals_vec.emplace_back();
	reachable_intervals_vec.back().emplace_back(first, last2);
	inputs.begin2 = reachable_intervals_vec.back().begin();
	inputs.end2 = reachable_intervals_vec.back().end();

	return inputs;
}
       
distance_t FrechetLight::calcDistance(Curve const& curve1, Curve const& curve2)
{
	static constexpr distance_t epsilon = 1e-10;

	distance_t min = 0.;
	distance_t max = curve1.getUpperBoundDistance(curve2);

	while (max - min >= epsilon) {
		auto split = (max + min)/2.;
		if (lessThanWithFilters(split, curve1, curve2)) {
			max = split;
		}
		else {
			min = split;
		}
	}

	return (max + min)/2.;
}

// This doesn't have to be called but is handy to make time measurements more consistent
// such that the clears in the lessThan call doen't have to do anything.
void FrechetLight::clear()
{
	reachable_intervals_vec.clear();
	qsimple_intervals.clear();

#ifdef VIS
	unknown_intervals.clear();
	connections.clear();
	free_non_reachable.clear();
	cells.clear();
	reachable_intervals.clear();
#endif
}

bool FrechetLight::isOnLowerRight(const CPosition& pt) const
{
	return pt[0] == curve_pair[0]->size()-1 or pt[1] == 0;
}
bool FrechetLight::isOnUpperLeft(const CPosition& pt) const
{
	return pt[0] == 0 or pt[1] == curve_pair[1]->size()-1;
}

Certificate& FrechetLight::computeCertificate() {
#ifndef CERTIFY
	return cert;
#else
	cert = Certificate();

	cert.setCurves(curve_pair[0], curve_pair[1]);
	cert.setDistance(distance);

	auto const& curve1 = *curve_pair[0];
	auto const& curve2 = *curve_pair[1];

	//TODO test handling of special cases!
	//special cases:
	if (curve1.front().dist_sqr(curve2.front()) > dist_sqr) { 
		cert.setAnswer(false);
		cert.addPoint({ CPoint(0, 0.), CPoint(0, 0.) });
		cert.validate();
		return cert;
       	}
	if (curve1.back().dist_sqr(curve2.back()) > dist_sqr) { 
		cert.setAnswer(false);
		cert.addPoint({ CPoint(curve1.size()-1, 0.), CPoint(curve2.size()-1, 0.) });
		cert.validate();
		return cert;
	}

	// cases where at least one curve has length 1
	if (curve1.size() == 1 && curve2.size() == 1) { 
		cert.setAnswer(true);
		cert.addPoint({ CPoint(0, 0.), CPoint(0, 0.) });
		cert.validate();
		return cert;
	}
	if (curve1.size() == 1) { 
		auto last = getLastReachablePoint(curve1.front(), curve2);
		if (last == CPoint(curve2.size()-1, 0.)) {
			cert.setAnswer(true);
			cert.addPoint({ CPoint(0, 0.), CPoint(0, 0.) });
			cert.addPoint({ CPoint(0, 0.), CPoint(curve2.size()-1, 0.) });
			cert.validate();
			return cert;
		} else {
		 	CInterval outer;
			(void) getInterval(curve1.front(), curve2, last.getPoint(), &outer);
			CPoint safe_empty = outer.begin > CPoint(last.getPoint(), 0.) ? outer.begin : outer.end;
			assert(safe_empty > CPoint(last.getPoint(), 0.) or safe_empty < CPoint(last.getPoint()+1, 0.));
			cert.setAnswer(false);
			cert.addPoint({ CPoint(0, 0.), safe_empty});
			cert.validate();
			return cert;
		}
	}
	if (curve2.size() == 1) { 
		auto last = getLastReachablePoint(curve2.front(), curve1);
		if (last == CPoint(curve1.size()-1, 0.)) {
			cert.setAnswer(true);
			cert.addPoint({ CPoint(0, 0.), CPoint(0, 0.) });
			cert.addPoint({ CPoint(curve1.size()-1, 0.), CPoint(0, 0.) });
			cert.validate();
			return cert;
		} else {
		 	CInterval outer;
			(void) getInterval(curve2.front(), curve1, last.getPoint(), &outer);
			CPoint safe_empty = outer.begin > CPoint(last.getPoint(), 0.) ? outer.begin : outer.end;
			assert(safe_empty > CPoint(last.getPoint(), 0.) or safe_empty < CPoint(last.getPoint()+1, 0.));
			cert.setAnswer(false);
			cert.addPoint({ safe_empty, CPoint(0, 0.)});
			cert.validate();
			return cert;
		}
	}


	//TODO: Check for case of a single point!



	CIntervals const& outputs1 = reachable_intervals_vec[2];
	CIntervals const& outputs2 = reachable_intervals_vec[3];

	bool answer = false;
	CInterval const* last_interval;
	if (outputs1.size() && (outputs1.back().end.getPoint() == curve1.size()-1)) {
		answer = true;
		last_interval = &outputs1.back();
	} else if (outputs2.size() && (outputs2.back().end.getPoint() == curve2.size()-1)) {
		answer = true;
		last_interval = &outputs2.back();
	}

	cert.setAnswer(answer);
	
	if (answer) {
		global::times.startComputeYesCertificate();
		CPositions rev_traversal;
		CPosition cur_pos = { CPoint(curve1.size()-1, 0.), CPoint(curve2.size()-1, 0.) };
		rev_traversal.push_back(cur_pos);
		CInterval const* interval = last_interval;
		while (cur_pos[0] > 0 or cur_pos[1] > 0) {
			CPosition  next_pos = {CPoint(0, 0.), CPoint(0, 0.)};

			next_pos[interval->fixed_curve] = interval->fixed;
			next_pos[1-interval->fixed_curve] = interval->end > cur_pos[1-interval->fixed_curve] ? cur_pos[1-interval->fixed_curve] : interval->end;
			assert(next_pos[0] <= cur_pos[0] and next_pos[1] <= cur_pos[1]);
			if (next_pos[0] != cur_pos[0] or next_pos[1] != cur_pos[1]) {
				rev_traversal.push_back(next_pos);
			}

			if (next_pos[1-interval->fixed_curve] != interval->begin) { 
				next_pos[1-interval->fixed_curve] = interval->begin;
				rev_traversal.push_back(next_pos);
			}

			assert(next_pos[0] <= cur_pos[0] and next_pos[1] <= cur_pos[1]);
			cur_pos = next_pos;
			interval = interval->reach_parent;
		}

		cert.validate();

		for (int t = rev_traversal.size() - 1; t >= 0; t--) {
			cert.addPoint(rev_traversal[t]);
		}

		global::times.stopComputeYesCertificate();
		return cert;

	} else {
		global::times.startComputeNoCertificate();
		global::times.startCountingCertEmptyIntervals(empty_intervals.size());
		global::times.startBuildOrthRangeSearch();

		CIntervalIDs stack;

		intervals_remaining.clear();
		for (CIntervalID intervalID = 0; intervalID < empty_intervals.size(); intervalID++) {
			CPosition lower_right = empty_intervals[intervalID].getLowerRightPos();
			if (isOnLowerRight(lower_right)) {
				stack.push_back(intervalID);

				global::times.incrementCertEmptyIntervalsInitial();
			} else {
				intervals_remaining.add({lower_right[0], lower_right[1]}, intervalID);
			}
		}
		intervals_remaining.build();
		global::times.stopBuildOrthRangeSearch();

		global::times.startFindNoTraversal();
		bool valid_cert = false;
		CInterval* last_interval = nullptr; 
		while (not stack.empty()) {
			CInterval& interval = empty_intervals[stack.back()];
			stack.pop_back();


			CPosition next_point = interval.getUpperLeftPos();
			//TODO move check for the first interval before the loop 
			if (isOnUpperLeft(next_point)) {
				valid_cert = true;
				last_interval = &interval;
				break;
			} else {
				auto first_new = stack.size();
				auto query_bottomright = interval.getLowerRightPos();
				if (query_bottomright[0] == next_point[0]) {
					query_bottomright[0] = CPoint(curve1.size()-1, 0.);
				} else {
					query_bottomright[1] = CPoint(0, 0.);
				}
				RangeSearch::Point query = {next_point[0], next_point[1]};
				intervals_remaining.searchAndDelete(query, stack);

				for (auto new_id = first_new; new_id < stack.size(); ++new_id) {
					auto reached = stack[new_id];
					assert(reached < empty_intervals.size());
					assert(empty_intervals[reached].begin >= 0);
					assert(empty_intervals[reached].end <= curve_pair[1-empty_intervals[reached].fixed_curve]->size() - 1);
					empty_intervals[reached].reach_parent = &interval;

					CPosition next_point = interval.getUpperLeftPos();
					if (isOnUpperLeft(next_point)) {
						valid_cert = true;
						last_interval = &interval;
						break;
					}

					global::times.incrementCertEmptyIntervalsEncountered();
				}
			}
		}
		global::times.stopFindNoTraversal();

		if (valid_cert) {
			CPositions rev_traversal;

			const CInterval* interval = last_interval;
			CPosition cur_pos;
			while (interval != nullptr) {
				CPosition next_pos = interval->getUpperLeftPos();
				if (cur_pos[0] != next_pos[0] or cur_pos[1] != next_pos[1]) {
					rev_traversal.push_back(next_pos);
				}

				next_pos = interval->getLowerRightPos();
				rev_traversal.push_back(next_pos);

				cur_pos = next_pos;

				interval = interval->reach_parent;
			}

			for (int t = rev_traversal.size() - 1; t >= 0; t--) {
				cert.addPoint(rev_traversal[t]);
			}


			cert.validate();
		}


		global::times.stopCountingCertEmptyIntervals();
		global::times.stopComputeNoCertificate();
		return cert;
	}
#endif
}

auto FrechetLight::getCurvePair() const -> CurvePair
{
	return curve_pair;
}

void FrechetLight::setPruningLevel(int pruning_level)
{
	this->pruning_level = pruning_level;
}

void FrechetLight::setRules(std::array<bool,5> const& enable)
{
	enable_box_shrinking = enable[0];
	enable_empty_outputs = enable[1];
	enable_propagation1 = enable[2];
	enable_propagation2 = enable[3];
	enable_boundary_rule = enable[4];
}

std::size_t FrechetLight::getNumberOfBoxes() const
{
	return num_boxes;
}
