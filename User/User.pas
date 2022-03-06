unit User;

interface
 type
  TUser = class
  private
    fName: string;
    fBalanceSpent: double;
    fBalance: double;
    fAddress: string;
  public
    OnEdit:procedure (const aUser:TUser) of object;
    property Name:string read fName;
    property Address:string read fAddress;
    property Balance:double read fBalance;
    property BalanceSpent:double read fBalanceSpent;
    procedure ReduceBalance(const aPrice:double);
    constructor Create(const aName: string;
                       const aBalanceSpent: double;
                       const aBalance: double;
                       const aAddress: string);
  end;
implementation

{ TUser }

constructor TUser.Create(const aName: string;
                         const aBalanceSpent: double;
                         const aBalance: double;
                         const aAddress: string);
begin
  fName:=aName;
  fBalanceSpent:=aBalanceSpent;
  fBalance:=aBalance;
  fAddress:=aAddress;
end;

procedure TUser.ReduceBalance(const aPrice: double);
begin
  fBalance:=fBalance-aPrice;
  fBalanceSpent:=fBalanceSpent+aPrice;
  if Assigned(OnEdit) then
    OnEdit(self);
end;

end.
