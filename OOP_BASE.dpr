program OOP_BASE;

uses
  Vcl.Forms,
  Product in 'Products\Product.pas',
  U_Main in 'U_Main.pas' {Form1},
  User in 'User\User.pas',
  Smartphone in 'Products\Smartphone.pas',
  Printer in 'Products\Printer.pas',
  ShoppingCart in 'ShoppingCart.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
