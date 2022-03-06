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

    //������������
    fUser:TUser;

    /// <summary>
    /// ������ �������
    /// </summary>
    fListProducts:TList<IProduct>;

    /// <summary>
    /// ������ ��������� �������
    /// </summary>
    fShoppingCart:TShoppingCart;

    /// <summary>
    /// ������� ��� ���������� ������,��������� �������
    /// </summary>
    Procedure LoadData;

    /// <summary>
    /// ������� ��� ��������� fListProducts(������ �� �������)
    /// </summary>
    procedure OnEditListProducts(Sender:Tobject;
                                 const Item:IProduct;
                                 Action:TCollectionNotification);
    /// <summary>
    /// ������� ��� ��������� ShoppingCart(��������� ������)
    /// </summary>
    procedure OnEditShoppingCart(Sender:Tobject;
                                 const Item:IProduct;
                                 Action:TCollectionNotification);
    /// <summary>
    /// ��������� ��� ��������� TreeView
    /// </summary>
    /// <param name="aTreeView">TreeView ������� ��������</param>
    /// <param name="aItem">����� ������� ��������</param>
    /// <param name="aAction">������� � ��������</param>
    procedure EditItemTreeView(const aTreeView:TTreeView;
                               const aItem: IProduct;
                               aAction: TCollectionNotification);
    /// <summary>
    /// ��������� ������ �� ������������ �� �����
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
  fUser:=TUser.Create('����',
                      5000,
                      25000,
                      '��.������� �.6 ��.12');
  //������������� �� ������������ ��������� ������������
  fUser.OnEdit:=ApplyUserInfo;
  //�������������� ���������� ���������� � ������������ �� �����
  ApplyUserInfo(fUser);
  //������� ������� ������������
  fShoppingCart:=TShoppingCart.Create(fUser);
  fShoppingCart.OnNotify:=OnEditShoppingCart;
  //������� ������ ���� �������
  fListProducts:=TList<IProduct>.create;
  //������������� �� ������������ ��������� ����� � ��������
  fListProducts.OnNotify:=OnEditListProducts;
  //��������� ������
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
 lbl_user_name.Caption:='������������: '+aUser.Name;
 lbl_user_balance.Caption:='������: '+FloatToStr(RoundTo(aUser.Balance,2));
end;

procedure TForm1.EditItemTreeView(const aTreeView:TTreeView;
                                  const aItem: IProduct;
                                  aAction: TCollectionNotification);
{$REGION '����� ���� � TreeView'}
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
      //TreeView ��� �������� �������� ��� OnDestroy
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
     //��� �������������� ������ ����� �������� �
     //Application.OnException � ��������� ������� � ����������� �����
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

    lbl_PersonalPrise.Caption := '������������ ����: '
                             + FloatToStr(SelectedProduct.DiscountPrice[fUser]);
  finally
    Characteristics.Free;
  end;
end;

end.
