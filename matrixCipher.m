function x = matrixCipher()
	%deschidem fisierele
	fid1 = fopen('input1A','r');
	fid2 = fopen('key1A','r');
	fout = fopen('output1A','w');
	%citim datele
	string = fgetl(fid1);	
	str = lower(string);
	n = fscanf(fid2,"%d",1);
	matrix = fscanf(fid2,"%d",[n n]);
	%prelucram vectorul de intregi, obtinut din sir
	v = zeros(1,length(str)-1);
	v = (str - 96);
	v = v(v~=-86);
	v(v == -57) = 28;
	v(v == -64) = 0;
	v(v == -50) = 27;
	%bordam vectorul daca e cazul
	while(rem(length(v),n) != 0)
		v = [v 0];
	end
	%calculam de cate ori intra n in v si formam vectorulk de inmultit
	y = length(v)/n;
	z = reshape(v, y , n);
	result = z(1:n) * matrix;
	%parcurgem fiecare bucata in parte
	for i = 1:y-1
		y1 = n*i;
		y2 = n*(i+1);
		%concatenam rezultatul
		res = z(y1+1:y2)*matrix;
		result = [result res];
	end
	%formam rezultatul final, punand valorile corespunzatoare din ASCII
	result = rem(result,29);
	result = result + 96;
	result(result == 96) = " ";
	result(result == 123) = ".";
	result(result == 124) = "'";	
	res_string = char(result);
	%printam si inchidem fisierele
	fprintf(fout, "%s", res_string);
	fclose(fid1);
	fclose(fid2);
	fclose(fout);
endfunction

