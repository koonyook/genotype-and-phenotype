program biology;

uses
  Forms,
  advancemode in '..\genotype and phenotype program\advancemode.pas' {checksort};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Genotype and Phenotype Program';
  Application.CreateForm(Tchecksort, checksort);
  Application.Run;
end.
