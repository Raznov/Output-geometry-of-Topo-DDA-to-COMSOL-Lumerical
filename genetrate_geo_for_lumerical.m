clear
tic


ratio_min = 0.9;
name1 = "thick400-diel2d5-phi0theta0-lam500-size1000-focus450-2D";
name2 = "CoreStructure99";

FileCommon="./" + name1 + "/Commondata.txt" ;
File = "./" + name1 + "/CoreStructure/" + name2 + ".txt";

FileCommonId=fopen(FileCommon, 'r');
FileId = fopen(File, 'r');



FileOut = name1+"_"+name2+".txt";
FileOutId = fopen(FileOut, 'w');
CommonData=textscan(FileCommonId, '%f');
Data = textscan(FileId, '%f');
Nx=CommonData{1}(1);
Ny=CommonData{1}(2);
Nz=CommonData{1}(3);
N=CommonData{1}(4);
R=CommonData{1}(5:(3*N+4));
d=CommonData{1}(3*N+5);

diel=Data{1}(1:3*N);


BinaryOut = zeros(Nx*Ny*Nz,1);

% for i = 1:N
%     if diel(3*i-2)>0.5
%         fprintf(FileOutId, '%d %d %d\n', R((3*i-2):(3*i)));
%     end
% end

for i = 1:N
    x=R(3*i-2);
    y=R(3*i-1);
    z=R(3*i);
    position=x+Nx*y+Nx*Ny*z+1;
    if diel(3*i-2)>0.5
        BinaryOut(position)=1;
    else
        BinaryOut(position)=0;
    end
end

fprintf(FileOutId, '%d %f %f\r\n', [Nx, d*0, d*(Nx-1)]);
fprintf(FileOutId, '%d %f %f\r\n', [Ny, d*0, d*(Ny-1)]);
fprintf(FileOutId, '%d %f %f\r\n', [Nz, d*0, d*(Nz-1)]);
fprintf(FileOutId, '%d\r\n', BinaryOut);









toc





fclose(FileOutId);
fclose(FileId);