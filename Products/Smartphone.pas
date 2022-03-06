unit Smartphone;

interface

uses Product,User,System.Generics.Collections,SysUtils;

  type
   TSmartphone = class(TProduct)
    private
      fScreenSize: Double;
    protected
      function GetDiscountPrice(const aUser: TUser): Double;override;
    public
      constructor Create(const aPrice:Double;
                         const aName:string;
                         const aProductOwner:string;
                         const aScreenSize: Double);
      property ScreenSize: Double read fScreenSize;
      function Title: string;override;
      function CharacteristicsList:TList<TCharacteristic>;override;
   end;
implementation

{ TSmartphone }

function TSmartphone.CharacteristicsList: TList<TCharacteristic>;
begin
 Result:=inherited CharacteristicsList;
 result.Add(TCharacteristic.Create('Размер экрана',
                                   FloatToStr(ScreenSize)
                                  )
           );
end;

constructor TSmartphone.Create(const aPrice:Double;
                               const aName:string;
                               const aProductOwner:string;
                               const aScreenSize: Double);
begin
  inherited Create(aPrice,
                   aName,
                   aProductOwner);
  fScreenSize:=aScreenSize;

end;

function TSmartphone.GetDiscountPrice(const aUser: TUser): Double;
begin
  result:=self.Price
end;

function TSmartphone.Title: string;
begin
  Result:='Смартфон '+inherited Title
end;

end.
