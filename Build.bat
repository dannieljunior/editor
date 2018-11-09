echo Criando arquivo de distribuição dos componentes...

set dirDestino="C:\DevCSharp\NDiversos\EngeLib"

set ano=%Date:~6,4%
set mes=%Date:~3,2%

set arquivoZip="Engelib.%ano%.%mes%.X.zip"

del /f *.zip

7z.exe a %arquivoZip% *.dpk *.cfg *.dcr *.dof *.res *.pdf dcu/*.dcu source/*.dfm source/*.RES