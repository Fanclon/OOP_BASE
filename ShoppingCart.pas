unit ShoppingCart;

interface
 uses User,Product,System.Generics.Collections,SysUtils;
 const ERR_NOT_ENOUGH_MONEY = '� ��� ������������ �������!';
 type TShoppingCart = class
  private
   fUser:TUser;
   fListProducts:TList<TProduct>;
   function GetNotify: TCollectionNotifyEvent<TProduct>;
   procedure SetNotify(const Value: TCollectionNotifyEvent<TProduct>);
  public
   constructor Create(const aUser:TUser);
   /// <summary>
   /// ������� ������
   /// </summary>
   /// <param name="aProduct">������� ������ ������ ������</param>
   /// <returns>������ � ������� ��� ������</returns>
   function BuyProduct(const aProduct:TProduct):Integer;
   /// <summary>
   /// C������ ��� ��������� ListProducts
   /// </summary>
   property OnNotify:TCollectionNotifyEvent<TProduct> read GetNotify write SetNotify;
   /// <summary>
   /// ������ ��������� ���������
   /// </summary>
   property ListProducts:TList<TProduct> read fListProducts;
 end;
implementation

{ TShoppingCart }

function TShoppingCart.BuyProduct(const aProduct: TProduct): Integer;
var Price:Double;
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
  fListProducts:=TList<TProduct>.Create;
end;

function TShoppingCart.GetNotify: TCollectionNotifyEvent<TProduct>;
begin
 Result:=fListProducts.OnNotify;
end;

procedure TShoppingCart.SetNotify(const Value: TCollectionNotifyEvent<TProduct>);
begin
  fListProducts.OnNotify:=Value;
end;

end.
