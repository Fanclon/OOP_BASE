unit Printer;

interface

uses Product,User,SysUtils,System.Generics.Collections;
  type
   TTypePrinterEnum = (//Лазерный
                        TP_LASER_0 = 0,
                        //Струйный
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
  /// Получение наименования для Типа принтера
  /// </summary>
  /// <param name="aTypePrinter">Типа принтера</param>
  /// <returns>Наименование</returns>
  function GetTypePrinterTitle(const aTypePrinter:TTypePrinterEnum):string;

implementation

function GetTypePrinterTitle(const aTypePrinter:TTypePrinterEnum):string;
begin
   case aTypePrinter of
     TP_LASER_0:
      begin
       Result:='Лазерный';
      end;
     TP_JET_1:
      begin
       Result:='Струйный';
      end;
    end;
end;

{ TPrinter }


function TPrinter.CharacteristicsList: TList<TCharacteristic>;
begin
 Result:=inherited CharacteristicsList;
 result.Add(TCharacteristic.Create('Технология печати',
                                   GetTypePrinterTitle(fTypePrinter)
                                  )
           );
 result.Add(TCharacteristic.Create('Скорость черно-белой печати (стр/мин)',
                                   FloatToStr(PrintSpeed)+' стр/мин (А4)'
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
    raise Exception.Create('Тип Принтера не определен (TPrinter.GetDiscountPrice)');
  end;
end;

function TPrinter.Title: string;
begin
Result:='Принтер '+GetTypePrinterTitle(fTypePrinter)+' '+inherited Title
end;

end.
