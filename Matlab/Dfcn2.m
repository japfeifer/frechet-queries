function dfcn2Val = Dfcn2(u,v,w)    
    dfcn2Val = 2*(sum((u-w).*(v-u)));
end