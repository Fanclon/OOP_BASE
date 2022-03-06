unit Printer;

interface

uses Product,User,SysUtils,System.Generics.Collections;
  type
   TTypePrinterEnum = (//��������
                        TP_LASER_0 = 0,
                        //��������
                        TP_JET_1 = 1
                      );
  type
   TPrinter = class(TProduct)
    private
      fTypePrinter:TTypePrinterEnum;
      fPrintSpeed: Double;
    protected
      function GetDiscountPrice(const aUser: TUser): Double;override;
    public
      constructor Create(const aPrice:Double;
                         const aName:string;
                         const aProductOwner:string;
                         const aPrintSpeed: Double;
                         const aTypePrinter:TTypePrinterEnum);
      property PrintSpeed: Double read fPrintSpeed;
      function Title: string;override;
      function CharacteristicsList: TList<TCharacteristic>;override;
   end;

  /// <summary>
  /// ��������� ������������ ��� ���� ��������
  /// </summary>
  /// <param name="aTypePrinter">���� ��������</param>
  /// <returns>������������</returns>
  function GetTypePrinterTitle(const aTypePrinter:TTypePrinterEnum):string;

implementation

function GetTypePrinterTitle(const aTypePrinter:TTypePrinterEnum):string;
begin
   case aTypePrinter of
     TP_LASER_0:
      begin
       Result:='��������';
      end;
     TP_JET_1:
      begin
       Result:='��������';
      end;
    end;
end;

{ TPrinter }


function TPrinter.CharacteristicsList: TList<TCharacteristic>;
begin
 Result:=inherited CharacteristicsList;
 result.Add(TCharacteristic.Create('���������� ������',
                                   GetTypePrinterTitle(fTypePrinter)
                                  )
           );
 result.Add(TCharacteristic.Create('�������� �����-����� ������ (���/���)',
                                   FloatToStr(PrintSpeed)+' ���/��� (�4)'
                                  )
           );
end;

constructor TPrinter.Create(const aPrice:Double;
                            const aName:string;
                            const aProductOwner:string;
                            const aPrintSpeed: Double;
                            const aTypePrinter:TTypePrinterEnum);
begin
  inherited Create(aPrice,
                   aName,
                   aProductOwner);

  fPrintSpeed:=aPrintSpeed;
  fTypePrinter:=aTypePrinter;
end;

function TPrinter.GetDiscountPrice(const aUser: TUser): Double;
begin
  case fTypePrinter of
   TP_LASER_0:
    begin
     Result:=self.Price;
    end;
   TP_JET_1:
    begin
     Result:=self.Price*0.80;
    end;
   else
    raise Exception.Create('��� �������� �� ��������� (TPrinter.GetDiscountPrice)');
  end;
end;

function TPrinter.Title: string;
begin
Result:='������� '+GetTypePrinterTitle(fTypePrinter)+' '+inherited Title
end;

end.
