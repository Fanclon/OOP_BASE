unit ShoppingCart;

interface
 uses User,Product,System.Generics.Collections,SysUtils;
 const ERR_NOT_ENOUGH_MONEY = '� ��� ������������ �������!';
 type TShoppingCart = class
  private
   fUser:TUser;
   fListProducts:TList<IProduct>;
   function GetNotify: TCollectionNotifyEvent<IProduct>;
   procedure SetNotify(const Value: TCollectionNotifyEvent<IProduct>);
  public
   constructor Create(const aUser:TUser);
   /// <summary>
   /// ������� ������
   /// </summary>
   /// <param name="aProduct">������� ������ ������ ������</param>
   /// <returns>������ � ������� ��� ������</returns>
   function BuyProduct(const aProduct:IProduct):Integer;
   /// <summary>
   /// C������ ��� ��������� ListProducts
   /// </summary>
   property OnNotify:TCollectionNotifyEvent<IProduct> read GetNotify write SetNotify;
   /// <summary>
   /// ������ ��������� ���������
   /// </summary>
   property ListProducts:TList<IProduct> read fListProducts;
   destructor Destroy; override;
 end;
implementation

{ TShoppingCart }

function TShoppingCart.BuyProduct(const aProduct: IProduct): Integer;
var
  Price:Double;
begin
  Price:=aProduct.DiscountPrice[fUser];
  if Price > fUser.Balance then
    raise Exception.Create(ERR_NOT_ENOUGH_MONEY)
  else
   begin
    //��������� ������
    fUser.ReduceBalance(Price);
    //��������� ����� � �������
    fListProducts.Add(aProduct);
   end;
end;

constructor TShoppingCart.Create(const aUser:TUser);
begin
  fUser:=aUser;
  fListProducts:=TList<IProduct>.Create;
end;

destructor TShoppingCart.Destroy;
begin
  fListProducts.Free;
  inherited;
end;

function TShoppingCart.GetNotify: TCollectionNotifyEvent<IProduct>;
begin
 Result:=fListProducts.OnNotify;
end;

procedure TShoppingCart.SetNotify(const Value: TCollectionNotifyEvent<IProduct>);
begin
  fListProducts.OnNotify:=Value;
end;

end.
