function X = strassen()
	fid = fopen('strassen.in','rt');
	fod = fopen('strassen.out','wt');
	n = fscanf(fid,'%g',1);
	A = fscanf(fid,'%i %g',[n n]);
	%dlmwrite(fod,A);
	%fprintf(fod,[repmat('%.3f ',1,[n n])],A');
	X = A;	
	fprintf(fod,'%i %.3g\n',X');
	fclose(fid);
	fclose(fod);
	
endfunction
