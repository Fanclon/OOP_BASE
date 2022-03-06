unit U_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,Vcl.ComCtrls,
  System.Generics.Collections, Vcl.StdCtrls, Vcl.ExtCtrls,
  Product,Smartphone,Printer,User,ShoppingCart, System.Actions, Vcl.ActnList;

type
  TForm1 = class(TForm)
    grp_Product: TGroupBox;
    gp_product: TGridPanel;
    tv_Product: TTreeView;
    grp_Specifications: TGroupBox;
    mmo_Characteristics: TMemo;
    pnl_product_buy: TPanel;
    btn_buy: TButton;
    lbl_PersonalPrise: TLabel;
    al_main: TActionList;
    a_buy: TAction;
    pnl_Right: TPanel;
    grp_cart: TGroupBox;
    tv_cart: TTreeView;
    grp_user: TGroupBox;
    lbl_user_balance: TLabel;
    lbl_user_name: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure tv_ProductChange(Sender: TObject; Node: TTreeNode);
    procedure a_buyExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }

    //Пользователь
    fUser:TUser;

    /// <summary>
    /// Список товаров
    /// </summary>
    fListProducts:TList<IProduct>;

    /// <summary>
    /// Список купленных товаров
    /// </summary>
    fShoppingCart:TShoppingCart;

    /// <summary>
    /// Создаем все небходимые классы,заполняем массивы
    /// </summary>
    Procedure LoadData;

    /// <summary>
    /// Событие при изменении fListProducts(Товары на продажу)
    /// </summary>
    procedure OnEditListProducts(Sender:Tobject;
                                 const Item:IProduct;
                                 Action:TCollectionNotification);
    /// <summary>
    /// Событие при изменении ShoppingCart(Купленные товары)
    /// </summary>
    procedure OnEditShoppingCart(Sender:Tobject;
                                 const Item:IProduct;
                                 Action:TCollectionNotification);
    /// <summary>
    /// Процедура для изменения TreeView
    /// </summary>
    /// <param name="aTreeView">TreeView который изменяем</param>
    /// <param name="aItem">Обект который изменяем</param>
    /// <param name="aAction">Событие с объектом</param>
    procedure EditItemTreeView(const aTreeView:TTreeView;
                               const aItem: IProduct;
                               aAction: TCollectionNotification);
    /// <summary>
    /// Заполняет данные по пользователю на форму
    /// </summary>
    procedure ApplyUserInfo(const aUser:TUser);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
 uses Math;
{$R *.dfm}
{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  LoadData;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
fUser.Free;
fListProducts.Free;
fShoppingCart.Free;
end;

procedure TForm1.LoadData;
begin
  fUser:=TUser.Create('Иван',
                      5000,
                      25000,
                      'Ул.Пушкина д.6 кв.12');
  //Подписываемся на отслеживание изменений пользователя
  fUser.OnEdit:=ApplyUserInfo;
  //Первоначальное заполнение информации о пользователе на форму
  ApplyUserInfo(fUser);
  //Создаем корзину пользователя
  fShoppingCart:=TShoppingCart.Create(fUser);
  fShoppingCart.OnNotify:=OnEditShoppingCart;
  //Создаем пустой лист товаров
  fListProducts:=TList<IProduct>.create;
  //Подписываемся на отслеживание изменений листа с Товарами
  fListProducts.OnNotify:=OnEditListProducts;
  //Заполняем товары
  fListProducts.Add(TSmartphone.Create(49999,
                                       'Galaxy S20 FE',
                                       'Samsung',
                                       6.5
                                      )
                   );
  fListProducts.Add(TSmartphone.Create(14999,
                                       'Redmi 9C',
                                       'Xiaomi',
                                       6.53
                                      )
                   );

  fListProducts.Add(TPrinter.Create(23699,
                                    'DCP-1623WR',
                                    'Brother',
                                    4.23,
                                    TP_LASER_0
                                   )
                   );

  fListProducts.Add(TPrinter.Create(5999,
                                    'DeskJet Plus 4130',
                                    'HP',
                                    8.5,
                                    TP_JET_1
                                   )
                   );



end;

procedure TForm1.OnEditListProducts(Sender: Tobject;
                                    const Item: IProduct;
                                    Action: TCollectionNotification);
begin
  EditItemTreeView(tv_Product,
                   Item,
                   Action);
end;

procedure TForm1.OnEditShoppingCart(Sender: Tobject;
                                    const Item: IProduct;
                                    Action: TCollectionNotification);
begin
  EditItemTreeView(tv_cart,
                   Item,
                   Action);
end;

procedure TForm1.ApplyUserInfo(const aUser: TUser);
begin
 lbl_user_name.Caption:='Пользователь: '+aUser.Name;
 lbl_user_balance.Caption:='Баланс: '+FloatToStr(RoundTo(aUser.Balance,2));
end;

procedure TForm1.EditItemTreeView(const aTreeView:TTreeView;
                                  const aItem: IProduct;
                                  aAction: TCollectionNotification);
{$REGION 'Поиск ноды в TreeView'}
function GetNodeTreeView(const aText: string): TTreeNode;
  var
    I: Integer;
  begin
    Result := nil;
    for I := 0 to aTreeView.Items.Count - 1 do
      if aTreeView.Items[I].Text = aText then
      begin
        Result := aTreeView.Items[I];
        Exit;
      end;
  end;
{$ENDREGION}

var Node:TTreeNode;
begin
  case aAction of
   cnAdded:
     begin
       aTreeView.Items.Add(NIL,aItem.Title);
     end;
   cnRemoved:
    begin
      //TreeView Уже частично разрушен при OnDestroy
      if not (csDestroying in aTreeView.ComponentState) then
        GetNodeTreeView(aItem.Title).Delete;
    end;
  end;
end;

procedure TForm1.a_buyExecute(Sender: TObject);
begin
 try

  fShoppingCart.BuyProduct(fListProducts[tv_Product.Selected.Index]);

 except on E: Exception do
   if E.Message = ERR_NOT_ENOUGH_MONEY then
     MessageDlg(E.Message,mtError, [mbOK], 0)
   else
     //Все необработанные ошибки можно отловить в
     //Application.OnException и отправить админам с расширенным логом
     raise Exception.Create(e.Message);
 end;
end;


procedure TForm1.tv_ProductChange(Sender: TObject; Node: TTreeNode);
var
  I: Integer;
  SelectedProduct: IProduct;
  Characteristics: TList<TCharacteristic>;
begin
  try
    mmo_Characteristics.Clear;
    SelectedProduct := fListProducts[Node.Index];
    Characteristics := SelectedProduct.CharacteristicsList;

    for I := 0 to Characteristics.Count - 1 do
      mmo_Characteristics.Lines.Add(Characteristics[I].ToString);

    lbl_PersonalPrise.Caption := 'Персональная цена: '
                             + FloatToStr(SelectedProduct.DiscountPrice[fUser]);
  finally
    Characteristics.Free;
  end;
end;

end.
