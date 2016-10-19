function x = decrypt()
	%deschidem fisierele
	fid1 = fopen('input1B','r');
	fid2 = fopen('key1B','r');
	fout = fopen('output1B','w');
	%citim datele
	string = fgetl(fid1);
	string = lower(string);
	n = fscanf(fid2,"%d",1);
	A = fscanf(fid2,"%d",[n n]);
	%concatenam matricea pe care o vom prelucra
	B = horzcat(A,eye(n));
	
	%facem trandformari liniare modulo 29 pentru a obtine modulo inversa
	for i =1:n
		[a b] = gcd(B(i,i),29);
		B(i,:) = mod(B(i,:)*b,29);
		for j = 1:i-1
			y=29-B(j,i);
			t = B(i,:)*y;
			B(j,:)=mod(B(j,:)+t,29);
		end
		for j = i+1:n
			y=29-B(j,i);
			t = B(i,:)*y;
			B(j,:)=mod(B(j,:)+t,29);
		end	

	end
	%scoatem matricea care ne trebuie
	C = B(:,n+1:2*n);
	D = C;

	%formam vectorul care ne trebuie
	v = zeros(1,length(string)-1);
	v = (string - 96);
	v = v(v~=-86);
	v(v == -57) = 28;
	v(v == -64) = 0;
	v(v == -50) = 27;
	while(rem(length(v),n) != 0)
		v = [v 0];
	end
	
	%formam vectorul de inmultit
	y = length(v)/n;
	z = reshape(v , y , n);
	result = z(1:n) * D;
	%inmultim pe bucati ca la punctul a
	for i = 1:y-1
		y1 = n*i;
		y2 = n*(i+1);
		res = z(y1+1:y2)*D;
		result = [result res];
	end

	%formam rezultatul final, respectand codurile ASCII
	result = rem(result,29);
	result = result + 96;
	result(result == 96) = " ";
	result(result == 123) = ".";
	result(result == 124) = "'";	
	res_string = char(result);
	fprintf(fout, "%s", res_string);
	
	%inchidem fisierele
	fclose(fid1);
	fclose(fout);
	fclose(fid2);
endfunction
