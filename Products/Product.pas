unit Product;

interface
uses User,System.Generics.Collections,SysUtils,System.Classes;
 type
  TCharacteristic = record
    Name:string;
    Value:string;
    class function Create(const aName:string;
                          const aValue:string):TCharacteristic;static;
    function ToString:string;
  end;

 type
  TProduct = class;

  IProduct = interface(IInterface)
    function GetName: string;
    function GetPrice: Double;
    function GetProductOwner: string;
    function GetDiscountPrice(const aUser: TUser): Double;
    property Price:Double read GetPrice;
    property Name: string read GetName;
    property ProductOwner: string read GetProductOwner;
    property DiscountPrice[const aUser:TUser]: Double read GetDiscountPrice;
    function Title:string;
    function CharacteristicsList:TList<TCharacteristic>;
    function Product:TProduct;
  end;


  TProduct = class(TInterfacedObject,IProduct)
   private
    fPrice: Double;
    fName: string;
    fProductOwner: string;
    function GetName: string;
    function GetPrice: Double;
    function GetProductOwner: string;
   protected
    function GetDiscountPrice(const aUser: TUser): Double;virtual;
   public
    constructor Create(const aPrice:Double;
                       const aName:string;
                       const aProductOwner:string);overload;

    property Price:Double read GetPrice;
    property Name: string read GetName;
    property ProductOwner: string read GetProductOwner;
    property DiscountPrice[const aUser:TUser]: Double read GetDiscountPrice;
    function Title:string;virtual;
    function CharacteristicsList:TList<TCharacteristic>;virtual;
    //Для приведения типа при необходимости из Интерфейса
    function Product:TProduct;
  end;

implementation

{ TProduct }

function TProduct.CharacteristicsList: TList<TCharacteristic>;
begin
 result:=TList<TCharacteristic>.Create;
 result.Add(TCharacteristic.Create('Производитель',
                                   ProductOwner
                                  )
           );
 result.Add(TCharacteristic.Create('Модель',
                                   Name
                                  )
           );
 result.Add(TCharacteristic.Create('Цена',
                                   FloatToStr(Price)
                                  )
           );

end;

constructor TProduct.Create(const aPrice:Double;
                            const aName:string;
                            const aProductOwner:string);
begin
  fPrice:=aPrice;
  fName :=aName;
  fProductOwner:=aProductOwner;
end;

function TProduct.GetDiscountPrice(const aUser: TUser): Double;
begin
  if aUser.BalanceSpent > 500 then
    Result:=Price*0.9
  else
    Result:=Price;
end;

function TProduct.GetName: string;
begin
 result:=fName;
end;

function TProduct.GetPrice: Double;
begin
 result:=fPrice;
end;

function TProduct.GetProductOwner: string;
begin
 result:=fProductOwner;
end;

function TProduct.Product: TProduct;
begin
 Result:=Self;
end;

function TProduct.Title: string;
begin
 Result:=ProductOwner+' '+Name;
end;

{ TCharacteristic }

class function TCharacteristic.Create(const aName: string;
                                      const aValue: string): TCharacteristic;
begin
  Result.Name:=aName;
  Result.Value:=aValue;
end;

function TCharacteristic.ToString: string;
begin
 Result:=self.Name+' : '+self.Value;
end;

end.
