function x = transposition()
	%deschidem fisierele	
	fid = fopen('input1C','r');
	fout1 = fopen('key1C','w');
	fout2 = fopen('output1C','w');
	%citim variabilele
	k = fscanf(fid, "%d" , 1);
	n = fscanf(fid,"%d\n",1);
	%formam sirul si matricea de codificare
	string = fgetl(fid);
	string = lower(string);
	A = eye(n+1);
	A(end,:) = k;
	dlmwrite(fout1,A,' ');
	A(:,end)=[];
	
	%modificam vectorul de numere dupa modelul din enunt	
	v = string - 96;
	v = v(v~=-86);
	v(v == -57) = 28;
	v(v == -64) = 0;
	v(v == -50) = 27;
	
	%calculam nr de mii din sir
	y = floor(length(v)/1000);
	%formam pasul principal
	p1=1;
	p2=n;
	%modificam matricea e codificare
	A(end,:) = 1;
	result = [];
	%verificam daca sunt mai mult de 1000 de numere
	if y>0
		%de cate ori intra n in 1000
		number = floor(1000/n);
		for i = 1:y
			%pentru numarul de n-uri efectuam calculele pe bucati, ca la punctul a
			%dupa care marim pasul
			for j = 1:number				
				z = [v(p1:p2) k] * A;
				result = [result z];		
				p2=p2+n;
				p1=p1+n;
			end
			%modificam si ultima parte a sirului de o mie, care nu mai e de 1xn			
			aux = v(p1:i*1000);
			a = eye(length(aux)+1);
			a(end,:) = 1;
			a(:,end)=[];
			z = [v(p1:i*1000) k] * a;
			result = [result z];
			k++;
			%modificam iar pasul
			p1=i*1000+1;
			p2=i*1000+n;
		end
	end
	%modificam partea din urma a sirului mare, care nu mai intregeste 1000
	aux = v(p1:length(v));
	a = eye(length(aux)+1);
	a(end,:) = 1;
	a(:,end)=[];
	z = [v(p1:length(v)) k] * a;
	result = [result z];	
	%formam rezultatul final	
	result = rem(result,29);
	result = result + 96;
	result(result == 96) = " ";
	result(result == 123) = ".";
	result(result == 124) = "'";
	res_string = char(result);
	%printam rezultatul final	
	fprintf(fout2, "%s\n", res_string);
	%inchidem fisierele
	fclose(fid);
	fclose(fout1);
	fclose(fout2);
endfunction
