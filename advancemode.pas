unit advancemode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls;

type
  Tchecksort = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    male: TEdit;
    female: TEdit;
    send: TButton;
    genotype: TMemo;
    phenotype: TMemo;
    help: TButton;
    editgroup: TGroupBox;
    selectgroup: TComboBox;
    g1: TMaskEdit;
    g2: TMaskEdit;
    g3: TMaskEdit;
    g4: TMaskEdit;
    incomplete: TMaskEdit;
    lethal: TMaskEdit;
    Apply: TButton;
    AddGroup: TButton;
    DeleteGroup: TButton;
    Back: TButton;
    First: TLabel;
    Second: TLabel;
    Third: TLabel;
    Fourth: TLabel;
    lableincom: TLabel;
    lableLethal: TLabel;
    Group: TLabel;
    swap: TButton;
    Label5: TLabel;
    selectadvance: TCheckBox;
    selectswap: TMaskEdit;
    gname: TEdit;
    lbName: TLabel;
    checksort: TCheckBox;
    procedure sendClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure helpClick(Sender: TObject);
    procedure selectadvanceClick(Sender: TObject);
    procedure AddGroupClick(Sender: TObject);
    procedure BackClick(Sender: TObject);
    procedure ApplyClick(Sender: TObject);
    procedure selectgroupChange(Sender: TObject);
    procedure swapClick(Sender: TObject);
    procedure DeleteGroupClick(Sender: TObject);
    procedure selectswapChange(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

type gene = record
  name:string;
  first:string;
  second:string;
  third:string;
  fourth:string;
  incom:string;
  leth:string;
end;

var
  checksort: Tchecksort;
  function isalpha(n:char):boolean;
  function isupper(n:char):boolean;
  function islower(n:char):boolean;
  function isnumber(str:string):boolean;
  function checkinputquick (str1:string;str2:string):boolean;
  function checkinputadvance (str1:string;str2:string):boolean;
  function sort(str:string):string;
  function order(c:char):integer;

implementation

{$R *.dfm}

var
  gg : array of gene;
  mem :gene;
  countgroup : integer;
  nowadd : boolean;

//function sortlast(ans:array of string;b:integer;va:array of integer):;

function isnumber(str:string):boolean;
var
q :boolean;
i,x,l :integer;
j :char;
begin
    l:=length(str);
    q:=true;
    for i:=1 to l do
    begin
        x:=0;
        for j:='0' to '9' do
        begin
            if str[i]=j then
                x:=x+1;
        end;
        if x=0 then
        begin
            isnumber:=false;
            q:=false
        end;
    end;
    if q=true then
        isnumber:=true;
end;

function isalpha(n:char):boolean;
var
 i:char;
 q:boolean;
begin
 q:=false;
 for i:='a' to 'z' do
  if n=i then q:=true;
 for i:='A' to 'Z' do
  if n=i then q:=true;
 isalpha:=q;
end;

function order(c:char):integer;
var
l1,l2,l3,l4,i :integer;
begin
    l1:=length(mem.first);
    l2:=length(mem.second);
    l3:=length(mem.third);
    l4:=length(mem.fourth);
  if l1<>0 then
    for i:=1 to l1 do
    begin
        if c=mem.first[i] then
        begin
            order:=1;
            break;
        end;
    end;
  if l2<>0 then
    for i:=1 to l2 do
    begin
        if c=mem.second[i] then
        begin
            order:=2;
            break;
        end;
    end;
  if l3<>0 then
    for i:=1 to l3 do
    begin
        if c=mem.third[i] then
        begin
            order:=3;
            break;
        end;
    end;
  if l4<>0 then
    for i:=1 to l4 do
    begin
        if c=mem.fourth[i] then
        begin
            order:=4;
            break;
        end;
    end;
end;

function sort(str:string):string;
var
    i,l :integer;
    m :char;
begin
    l:=length(str);
    for i:=1 to ((l+1) div 3) do
    begin
      {**** sort by order}
      if order(str[(i*3)-2])<>order(str[(i*3)-1]) then
      begin
        if order(str[(i*3)-2])>order(str[(i*3)-1]) then
        begin
            m:=str[(i*3)-2];
            str[(i*3)-2]:=str[(i*3)-1];
            str[(i*3)-1]:=m;
        end;
      end
      else
      begin
        if islower(str[(i*3)-2]) and isupper(str[(i*3)-1]) then
        begin
            m:=str[(i*3)-2];
            str[(i*3)-2]:=str[(i*3)-1];
            str[(i*3)-1]:=m;
        end
        else if (islower(str[(i*3)-2]) and islower(str[(i*3)-1])) or (isupper(str[(i*3)-2]) and isupper(str[(i*3)-1])) then
        begin
            if str[(i*3)-2]>str[(i*3)-1] then
            begin
            m:=str[(i*3)-2];
            str[(i*3)-2]:=str[(i*3)-1];
            str[(i*3)-1]:=m;
            end;
        end;
      end;
    end;
    sort:=str;
end;

function isupper(n:char):boolean;
var
 i:char;
 q:boolean;
begin
 q:=false;
 for i:='A' to 'Z' do
  if n=i then q:=true;
 isupper:=q;
end;

function islower(n:char):boolean;
var
 i:char;
 q:boolean;
begin
 q:=false;
 for i:='a' to 'z' do
  if n=i then q:=true;
 islower:=q;
end;

function checkinputquick (str1:string;str2:string):boolean;
var
 i:integer;
 long1,long2:integer;
begin
 long1:=length(str1);
 long2:=length(str2);
 if long1<>long2 then
 begin
  showmessage('กรุณากรอกให้เท่ากันทั้งสองช่องด้วยครับ');
  checkinputquick:=false;
  exit;
 end
 else
  if (long1 mod 2)=1 then
  begin
  showmessage('กรุณากรอกเป็นคู่ครับ');
  checkinputquick:=false;
  exit;
  end
  else
  for i:=1 to long1 do
  begin
    if not(isalpha(str1[i])) or not(isalpha(str2[i])) then
    begin
     showmessage('กรอกเป็นตัวอักษรภาษาอังกฤษเท่านั้นครับ');
     checkinputquick:=false;
     exit;
    end
  end;
  checkinputquick:=true;
end;

function checkinputadvance (str1:string;str2:string):boolean;
var
 i,j,lg,long1,long2,c1,c2,c3,c4:integer;
 g:string;
begin
 long1:=length(str1);
 long2:=length(str2);
 if long1<>long2 then
 begin
  showmessage('กรุณากรอกให้เท่ากันทั้งสองช่องด้วยครับ');
  checkinputadvance:=false;
  exit;
 end
 else
  if (long1 mod 2)=1 then
  begin
  showmessage('กรุณากรอกเป็นคู่ครับ');
  checkinputadvance:=false;
  exit;
  end
  else
  for i:=1 to long1 do
  begin
    if not(isalpha(str1[i])) or not(isalpha(str2[i])) then
    begin
     showmessage('กรอกเป็นตัวอักษรภาษาอังกฤษเท่านั้นครับ');
     checkinputadvance:=false;
     exit;
    end;
  end;
  if (long1 div 2)<>countgroup then
  begin
     showmessage('คุณใช้ยีนไม่เท่าจำนวนกลุ่มที่คุณสร้างไว้');
     checkinputadvance:=false;
     exit;
  end;
  for i:=1 to (long1 div 2) do
  begin
    g:=gg[i-1].first+gg[i-1].second+gg[i-1].third+gg[i-1].fourth;
    lg:=length(g);
    c1:=0;
    c2:=0;
    c3:=0;
    c4:=0;
    for j:=1 to lg do
    begin
        if str1[(i*2)-1]=g[j] then
            c1:=1;
        if str1[(i*2)]=g[j] then
            c2:=1;
        if str2[(i*2)-1]=g[j] then
            c3:=1;
        if str2[(i*2)]=g[j] then
            c4:=1;
    end;
    if (c1+c2+c3+c4)<>4 then
    begin
        showmessage('มียีนบางตัวที่คุณไม่ได้สร้างไว้ หรือคุณใส่ตำแหน่งยีนไม่ตรงกับกลุ่มที่คุณสร้างไว้');
        checkinputadvance:=false;
        exit;
    end;
  end;
  checkinputadvance:=true;
end;

procedure Tchecksort.sendClick(Sender: TObject);
var
 b,z,y,x,i,long,total,di,mva :integer;
 fe,ma,cc,space,mans : string;
 m,f,ans : array of string;
 A : array of array[1..4] of string;
 va,ac : array of integer;
 inc:boolean;
begin
 for x:=genotype.Lines.Count downto 0 do
  genotype.Lines.Delete(x);
 for x:=phenotype.Lines.Count downto 0 do
  phenotype.Lines.Delete(x);
 fe:=female.Text;
 ma:=male.Text;

 if selectadvance.Checked then
 begin   //งานของ advance mode  ************************
 if (fe='') and (ma='') then exit;
 if checkinputadvance(fe,ma) then   //
 begin
  long:=length(fe) div 2;
  setlength(f,long);
  setlength(m,long);
  for x:=0 to (long-1) do
  begin
   f[x]:=fe[(x*2)+1]+fe[(x*2)+2];
   m[x]:=ma[(x*2)+1]+ma[(x*2)+2];
  end;



  setlength(A,long);
  for x:=0 to (long-1) do
  begin
   mem:=gg[x];
   b:=1;
   for y:=1 to 2 do
   begin
    for z:=1 to 2 do
    begin       //sort to A ******************
        if order(f[x,y])>order(m[x,z]) then A[x,b]:=m[x,z]+f[x,y]
        else if order(f[x,y])<order(m[x,z]) then A[x,b]:=f[x,y]+m[x,z]
        else if order(f[x,y])=order(m[x,z]) then
        begin
            if isupper(f[x,y]) and islower(m[x,z]) then A[x,b]:=f[x,y]+m[x,z]
            else if islower(f[x,y]) and isupper(m[x,z]) then A[x,b]:=m[x,z]+f[x,y]
            else if f[x,y]<m[x,z] then A[x,b]:=f[x,y]+m[x,z]
            else A[x,b]:=m[x,z]+f[x,y];
        end;
     b:=b+1;
    end;
   end;
  end;

  b:=1;
  for x:=1 to long do
  begin
   b:=b*4;
  end;
  setlength(ans,b);
  setlength(va,b);
  setlength(ac,long);

  for x:=0 to long-1 do
   ac[x]:=1;
  for x:=0 to b-1 do
   va[x]:=1;

  for x:=0 to b-1 do
  begin
   for y:=0 to long-1 do
    ans[x]:=ans[x]+A[y,ac[y]];

   ac[long-1]:=ac[long-1]+1;
   for z:=long-1 downto 0 do
   begin
    if ac[z]=5 then
    begin
     ac[z]:=1;
     ac[z-1]:=ac[z-1]+1;
    end;
   end;
  end;
  for x:=1 to b-1 do
  begin
   for y:=0 to x-1 do
   begin
    if ans[x]=ans[y] then
    begin
     va[y]:=va[y]+va[x];
     ans[x]:='';
     va[x]:=0;
     //break;
    end;
   end;
  end;
  // cut lethal
  for x:=0 to b-1 do
  begin
    if ans[x]<>'' then
    begin
        for y:=1 to countgroup do
        begin
            mem:=gg[y-1];
            if mem.leth<>'' then
            begin
                for z:=1 to ((length(mem.leth)+1) div 3) do
                begin
                    if ans[x,(y*2)-1]+ans[x,y*2]=mem.leth[(z*3)-2]+mem.leth[(z*3)-1] then
                    begin
                        va[x]:=0;
                        ans[x]:=''; //เพิ่มมาทีหลัง เพื่อ ไม่ให้มี lethal เหลืออยู่เลย
                        break;
                    end;
                end;
            end;
            if va[x]=0 then break;
        end;
    end;
  end;

  total:=0;
  for x:=0 to b-1 do
   total:=total+va[x];
  di:=1;
  for x:=total downto 1 do
  begin
   z:=0;
   for y:=0 to b-1 do
   begin
    if (va[y] mod x)<>0 then
    begin
     z:=1;
     break;
    end;
   end;
   if z=0 then
   begin
    di:=x;
    break;
   end;
  end;

  //เรียงจากอัตราส่วนมากไปน้อย
 if checksort.Checked then
 begin
  for x:=0 to b-2 do
  begin
    for y:=0 to b-2 do
    begin
        if va[y]<va[y+1] then
        begin
            mva:=va[y];
            mans:=ans[y];

            va[y]:=va[y+1];
            ans[y]:=ans[y+1];

            va[y+1]:=mva;
            ans[y+1]:=mans;
        end;
    end;
  end;
 end;

  for x:=0 to b-1 do
  begin
   if ans[x]<>'' then
        genotype.lines.Add(ans[x]+{#9+inttostr(va[x])+} #9+inttostr(va[x] div di)+#9+currtostr( ((va[x])*100/total) )+'%'  );
        //genotype.lines.Add(ans[x]+#9+inttostr(va[x])+#9+inttostr(va[x] div di)); //แสดงผลgnotype
  end;

  space:='';
  if long>3 then
  begin
    for x:=4 to long do
    begin
        space:=space+'  ';
    end;
  end;
  genotype.lines.Add('');
  genotype.lines.Add('total='+space+#9+{inttostr(total)+#9+} inttostr(total div di)+#9+'100%');
  //genotype.lines.Add('total='+space+#9+inttostr(total)+#9+inttostr(total div di));

  for x:=0 to b-1 do
  begin
   if (ans[x]<>'') and (va[x]<>0) then
   begin   ///////////////////cut for phenotype



    for y:=1 to long do
    begin
    mem:=gg[y-1];
    cc:=ans[x,(y*2)-1]+ans[x,y*2];
    inc:=false;
        if mem.incom<>'' then
        begin
            for z:=1 to ((length(mem.incom)+1) div 3) do
            begin
                if cc=mem.incom[(z*3)-2]+mem.incom[(z*3)-1] then
                begin
                    inc:=true;
                end;
            end;
            //if inc=true then break;
        end;

        if ( ( (order(ans[x,(2*y)-1]))<(order(ans[x,2*y])) ) and (inc=false) ) then
        begin
            ans[x,2*y]:=' ';      ////แทรกที่ว่าง
        end;

        if (ans[x,(y*2)-1]=ans[x,y*2]) then
        begin
            ans[x,2*y]:=' ';      /////แทรกที่ว่าง
        end;
    end;
   end;
  end;

  for x:=1 to b-1 do
  begin
   for y:=0 to x-1 do
   begin
    if ans[x]=ans[y] then
    begin
     va[y]:=va[y]+va[x];
     ans[x]:='';
     va[x]:=0;
     //break;
    end;
   end;
  end;

  for x:=total downto 1 do
  begin
   z:=0;
   for y:=0 to b-1 do
   begin
    if (va[y] mod x)<>0 then
    begin
     z:=1;
     break;
    end;
   end;
   if z=0 then
   begin
    di:=x;
    break;
   end;
  end;

  //เรียงจากอัตราส่วนมากไปน้อย
 if checksort.Checked then
 begin
  for x:=0 to b-2 do
  begin
    for y:=0 to b-2 do
    begin
        if va[y]<va[y+1] then
        begin
            mva:=va[y];
            mans:=ans[y];

            va[y]:=va[y+1];
            ans[y]:=ans[y+1];

            va[y+1]:=mva;
            ans[y+1]:=mans;
        end;
    end;
  end;
 end;

  for x:=0 to b-1 do
  begin
   if ans[x]<>'' then
        phenotype.lines.Add(ans[x]+{#9+inttostr(va[x])+} #9+inttostr(va[x] div di)+#9+currtostr( ((va[x])*100/total) )+'%'  );
        //phenotype.lines.Add(ans[x]+#9+inttostr(va[x])+#9+inttostr(va[x] div di)); //แสดงผลfenotype
  end;
  phenotype.lines.Add('');
  phenotype.lines.Add('total='+space+#9+{inttostr(total)+#9+} inttostr(total div di)+#9+'100%');
  //phenotype.lines.Add('total='+space+#9+inttostr(total)+#9+inttostr(total div di));
 end;
 end
 //จบAdvancemode


 else
 begin //งานของ Quick mode
 if (fe='') and (ma='') then
    exit;
 if checkinputquick(fe,ma) then
 begin
  long:=length(fe) div 2;
  setlength(f,long);
  setlength(m,long);
  for x:=0 to (long-1) do
  begin
   f[x]:=fe[(x*2)+1]+fe[(x*2)+2];
   m[x]:=ma[(x*2)+1]+ma[(x*2)+2];
  end;



  setlength(A,long);
  for x:=0 to (long-1) do
  begin
   b:=1;
   for y:=1 to 2 do
   begin
    for z:=1 to 2 do
    begin
     if isupper(f[x,y]) and islower(m[x,z]) then A[x,b]:=f[x,y]+m[x,z]
     else if islower(f[x,y]) and isupper(m[x,z]) then A[x,b]:=m[x,z]+f[x,y]
     else if f[x,y]<m[x,z] then A[x,b]:=f[x,y]+m[x,z]
     else A[x,b]:=m[x,z]+f[x,y];
     b:=b+1;
    end;
   end;
  end;

  b:=1;
  for x:=1 to long do
  begin
   b:=b*4;
  end;
  setlength(ans,b);
  setlength(va,b);
  setlength(ac,long);

  for x:=0 to long-1 do
   ac[x]:=1;
  for x:=0 to b-1 do
   va[x]:=1;

  for x:=0 to b-1 do
  begin
   for y:=0 to long-1 do
    ans[x]:=ans[x]+A[y,ac[y]];

   ac[long-1]:=ac[long-1]+1;
   for z:=long-1 downto 0 do
   begin
    if ac[z]=5 then
    begin
     ac[z]:=1;
     ac[z-1]:=ac[z-1]+1;
    end;
   end;
  end;
  for x:=1 to b-1 do
  begin
   for y:=0 to x-1 do
   begin
    if ans[x]=ans[y] then
    begin
     va[y]:=va[y]+va[x];
     ans[x]:='';
     va[x]:=0;
     //break;
    end;
   end;
  end;

  total:=0;
  for x:=0 to b-1 do
   total:=total+va[x];
  di:=1;
  for x:=total downto 1 do
  begin
   z:=0;
   for y:=0 to b-1 do
   begin
    if (va[y] mod x)<>0 then
    begin
     z:=1;
     break;
    end;
   end;
   if z=0 then
   begin
    di:=x;
    break;
   end;
  end;

    //เรียงจากอัตราส่วนมากไปน้อย
 if checksort.Checked then
 begin
  for x:=0 to b-2 do
  begin
    for y:=0 to b-2 do
    begin
        if va[y]<va[y+1] then
        begin
            mva:=va[y];
            mans:=ans[y];

            va[y]:=va[y+1];
            ans[y]:=ans[y+1];

            va[y+1]:=mva;
            ans[y+1]:=mans;
        end;
    end;
  end;
 end;

  for x:=0 to b-1 do
  begin
   if ans[x]<>'' then
     genotype.lines.Add(ans[x]+{#9+inttostr(va[x])+} #9+inttostr(va[x] div di)+#9+currtostr( ((va[x])*100/total) )+'%'  ); //แสดงผลgnotype
  end;

  space:='';
  if long>3 then
  begin
    for x:=4 to long do
    begin
        space:=space+'  ';
    end;
  end;
  genotype.lines.Add('');
  genotype.lines.Add('total='+space+#9+{inttostr(total)+#9+} inttostr(total div di)+#9+'100%');

  for x:=0 to b-1 do
  begin
   if ans[x]<>'' then
   begin
    for y:=1 to long do
     ans[x,2*y]:=' ';    //ใส่ที่ว่าง
   end;
  end;

  for x:=1 to b-1 do
  begin
   for y:=0 to x-1 do
   begin
    if ans[x]=ans[y] then
    begin
     va[y]:=va[y]+va[x];
     ans[x]:='';
     va[x]:=0;
     //break;
    end;
   end;
  end;

  for x:=total downto 1 do
  begin
   z:=0;
   for y:=0 to b-1 do
   begin
    if (va[y] mod x)<>0 then
    begin
     z:=1;
     break;
    end;
   end;
   if z=0 then
   begin
    di:=x;
    break;
   end;
  end;

    //เรียงจากอัตราส่วนมากไปน้อย
 if checksort.Checked then
 begin
  for x:=0 to b-2 do
  begin
    for y:=0 to b-2 do
    begin
        if va[y]<va[y+1] then
        begin
            mva:=va[y];
            mans:=ans[y];

            va[y]:=va[y+1];
            ans[y]:=ans[y+1];

            va[y+1]:=mva;
            ans[y+1]:=mans;
        end;
    end;
  end;
 end;

  for x:=0 to b-1 do
  begin
   if ans[x]<>'' then
        phenotype.lines.Add(ans[x]+{#9+inttostr(va[x])+} #9+inttostr(va[x] div di)+#9+currtostr( ((va[x])*100/total))+'%'); //แสดงผลfenotype
  end;
  phenotype.lines.Add('');
  phenotype.lines.Add('total='+space+#9+{inttostr(total)+#9+} inttostr(total div di)+#9+'100%');
 end;
 end; //end for quick mode
end;



procedure Tchecksort.FormCreate(Sender: TObject);
begin
 countgroup:=0;
 nowadd:=false;
 genotype.Lines.Delete(0);
 phenotype.Lines.Delete(0);
 addgroup.Enabled:=false;
 selectgroup.Enabled:=false;
 gname.Enabled:=false;
 g1.Enabled:=false;
 g2.Enabled:=false;
 g3.Enabled:=false;
 g4.Enabled:=false;
 incomplete.Enabled:=false;
 lethal.Enabled:=false;
 back.Enabled:=false;
 apply.Enabled:=false;
 swap.Enabled:=false;
 selectswap.Enabled:=false;
 deletegroup.Enabled:=false;

 group.Enabled:=false;
 lbname.Enabled:=false;
 first.Enabled:=false;
 second.Enabled:=false;
 third.Enabled:=false;
 fourth.Enabled:=false;

 lableincom.Enabled:=false;
 lablelethal.Enabled:=false;
 label5.Enabled:=false;
 editgroup.Font.Color:=ClGrayText;
end;

procedure Tchecksort.helpClick(Sender: TObject);
begin
if selectadvance.Checked then
 begin
    showmessage('การใช้งานใน Advance Mode'+#13#10+'คุณต้องทำการ Add Group โดยการกรอกตัวอักษร ให้เติมโดยดูรูปแบบได้จากการนำลูกศรไปวางบนช่องที่จะเติม ก็จะมี Hint ขึ้นมา เมื่อกรอกเสร็จ ให้กด Apply'+#13#10+'คุณสามารถเพิ่มกลุ่มของยีนที่จะใช้ได้หลายกลุ่ม และสามารถตรวจสอบและแก้ไขยีนของแต่ละกลุ่มได้โดยการเลือกกลุ่มในช่อง Group เพื่อดู และ ถ้ามีการแก้ไขให้กด Apply เพื่อเปลี่ยนแปลงข้อมูลใหม่ในกลุ่มนั้น'+#13#10+'การกรอกยีนในช่อง Female และ Male ให้กรอกให้จำนวนคู่ตรงกับจำนวนกลุ่มที่คุณได้สร้างไว้ และกรอกให้ลำดับของคู่ยีนตรงกับลำดับของกลุ่มที่เรียงกันอยู่ แล้วกด Process ผลที่ได้ในแถวแรกจะเป็นอัตราส่วนในแต่ละลักษณะของรุ่นลูก แถวสองจะเป็นเปอร์เซ็นต์ของทั้งหมด'+#13#10+'คุณสามารถลบกลุ่มที่คุณไม่ต้องการใช้ได้โดย เลือกกลุ่มจากช่อง Group แล้วกด Delete This Group เมื่อลบแล้ว กลุ่มถัด ๆ ไปจะเลื่อนเข้ามา'+#13#10+'ถ้าคุณต้องการสลับกลุ่ม ให้คุณเลือกกลุ่มจากช่อง Group (บน) แล้วเลือกกลุ่มที่ต้องการสลับในช่อง Group (ล่าง) แล้วกด Swap Group with');
    //helpของ advance mode
 end
 else
    showmessage('การใช้งานใน Quick Mode'+#13#10+'เพียงคุณใส่ genotype ของเพศผู้และเพศเมีย เช่น AahHuU ทั้งสองช่องโดยให้ลำดับของคู่ยีนตรงกัน แล้วกด send คุณก็จะทราบอัตราส่วน genotype และ phenotype ได้จากตัวเลขในแถวแรก และแถวที่สองเป็นเปอร์เซ็นต์ของทั้งหมดซึ่งประมาณเป็นทศนิยมสี่ตำแหน่ง'+#13#10+'โดยในโหมดนี้ ตัวอักษรใหญ่จะข่มตัวอักษรเล็กและถ้าตัวใหญ่หรือตัวเล็กเหมือนกัน อักษรที่มาก่อนจะข่มตัวอักษรที่มาทีหลัง'+#13#10+'ถ้าคุณต้องการกำหนด การมี Lethal, Codominance หรือ Incomplete ให้คุณใช้ Advance Mode');
end;

procedure Tchecksort.selectadvanceClick(Sender: TObject);
begin
    if selectadvance.Checked then
    begin
        addgroup.Enabled:=true;
        selectgroup.Enabled:=true;
        gname.Enabled:=true;
        g1.Enabled:=true;
        g2.Enabled:=true;
        g3.Enabled:=true;
        g4.Enabled:=true;
        incomplete.Enabled:=true;
        lethal.Enabled:=true;
        apply.Enabled:=true;
        swap.Enabled:=true;
        selectswap.Enabled:=true;
        deletegroup.Enabled:=true;

        group.Enabled:=true;
        lbname.Enabled:=true;
        first.Enabled:=true;
        second.Enabled:=true;
        third.Enabled:=true;
        fourth.Enabled:=true;

        lableincom.Enabled:=true;
        lablelethal.Enabled:=true;
        label5.Enabled:=true;
        editgroup.Font.Color:=ClWindowText;
    end
    else
    begin
        addgroup.Enabled:=false;
        selectgroup.Enabled:=false;
        gname.Enabled:=false;
        g1.Enabled:=false;
        g2.Enabled:=false;
        g3.Enabled:=false;
        g4.Enabled:=false;
        incomplete.Enabled:=false;
        lethal.Enabled:=false;
        back.Enabled:=false;
        apply.Enabled:=false;
        swap.Enabled:=false;
        selectswap.Enabled:=false;
        deletegroup.Enabled:=false;

        group.Enabled:=false;
        lbname.Enabled:=false;
        first.Enabled:=false;
        second.Enabled:=false;
        third.Enabled:=false;
        fourth.Enabled:=false;

        lableincom.Enabled:=false;
        lablelethal.Enabled:=false;
        label5.Enabled:=false;
        editgroup.Font.Color:=ClGrayText;
    end;
end;



procedure Tchecksort.AddGroupClick(Sender: TObject);
begin
    label1.Enabled:=false;
    label2.Enabled:=false;
    label3.Enabled:=false;
    label4.Enabled:=false;
    male.Enabled:=false;
    female.Enabled:=false;
    genotype.Enabled:=false;
    phenotype.Enabled:=false;

    send.Enabled:=false;
    addgroup.Enabled:=false;
    selectadvance.Enabled:=false;

    swap.Enabled:=false;
    selectswap.Enabled:=false;
    label5.Enabled:=false;
    deletegroup.Enabled:=false;
    back.Enabled:=true;
    selectgroup.Text:='New Group ('+inttostr(countgroup+1)+')';
    selectgroup.Enabled:=false;
    nowadd:=true;

    gname.Clear;
    g1.Clear;
    g2.Clear;
    g3.Clear;
    g4.Clear;
    incomplete.Clear;
    lethal.Clear;
end;

procedure Tchecksort.BackClick(Sender: TObject);
begin
    label1.Enabled:=true;
    label2.Enabled:=true;
    label3.Enabled:=true;
    label4.Enabled:=true;
    male.Enabled:=true;
    female.Enabled:=true;
    genotype.Enabled:=true;
    phenotype.Enabled:=true;

    send.Enabled:=true;
    addgroup.Enabled:=true;
    selectadvance.Enabled:=true;

    swap.Enabled:=true;
    selectswap.Enabled:=true;
    label5.Enabled:=true;
    deletegroup.Enabled:=true;
    back.Enabled:=false;
    selectgroup.Enabled:=true;
    selectgroup.Text:='';
    nowadd:=false;

    gname.Clear;
    g1.Clear;
    g2.Clear;
    g3.Clear;
    g4.Clear;
    incomplete.Clear;
    lethal.Clear;
end;

procedure Tchecksort.ApplyClick(Sender: TObject);
var
    str,inco,le:string;
    l,m,n,i,j,x:integer;
begin
  if selectgroup.Text='' then
  begin
    showmessage('คุณไม่ได้ระบุกลุ่ม');
    exit;
  end;
  //checkapply

  if g1.Text='' then
  begin
    if g2.Text<>'' then
    begin
        g1.Text:=g2.Text;
        g2.Text:='';
    end
    else if g3.Text<>'' then
    begin
        g1.Text:=g3.Text;
        g3.Text:='';
    end
    else if g4.Text<>'' then
    begin
        g1.Text:=g4.Text;
        g4.Text:='';
    end;
  end;
  if g2.Text='' then
  begin
    if g3.Text<>'' then
    begin
        g2.Text:=g3.Text;
        g3.Text:='';
    end
    else if g4.Text<>'' then
    begin
        g2.Text:=g4.Text;
        g4.Text:='';
    end;
  end;
  if g3.Text='' then
  begin
    if g4.Text<>'' then
    begin
        g3.Text:=g4.Text;
        g4.Text:='';
    end;
  end;
  //finish move
  if g1.Text='' then
  begin
    showmessage('คุณไม่ได้ใส่ยีน');
    exit;
  end;
  str:=''+g1.Text+g2.Text+g3.Text+g4.Text;
  l:=length(str);
  for i:=1 to l do
  begin
    if not(isalpha(str[i])) then
    begin
        showmessage('กรุณากรอกเป็นตัวอักษรภาษาอังกฤษเท่านั้น');
        exit;
    end;
  end;
  for i:=1 to l-1 do
  begin
    for j:=i+1 to l do
    begin
        if str[i]=str[j] then
        begin
            showmessage('คุณกรอกยีนซำ้กัน กรุณาแก้ไขแล้วกด Apply อีกครั้ง');
            exit;
        end;
    end;
  end;
  //ตรวจยีนซำ้
  inco:=incomplete.Text;
  le:=lethal.Text;
  m:=length(inco);
  n:=length(le);
  if ( (((m+1) mod 3)=0) or (m=0) ) and ( (((n+1) mod 3)=0) or (n=0) ) then
  begin
    if m<>0 then
    begin
        for i:=1 to m do
        begin
            if (i mod 3 =1) or (i mod 3 =2) then
            begin
                x:=0;
                for j:=1 to l do
                    if inco[i]=str[j] then
                        x:=1;

                if not(isalpha(inco[i])) or (x=0) then
                begin
                    showmessage('กรุณากรอกช่อง Incomplete และ Recessive Lethal ให้ถูกต้องด้วยครับ');
                    exit;
                end;
            end
            else
            begin
                if not(inco[i]=',') then
                begin
                    showmessage('กรุณากรอกช่อง Incomplete และ Recessive Lethal ให้ถูกต้องด้วยครับ');
                    exit;
                end;
            end;
        end;
    end;
    if n<>0 then
    begin
        for i:=1 to n do
        begin
            if (i mod 3 =1) or (i mod 3 =2) then
            begin
                x:=0;
                for j:=1 to l do
                    if le[i]=str[j] then
                        x:=1;

                if not(isalpha(le[i])) or (x=0) then
                begin
                    showmessage('กรุณากรอกช่อง Incomplete และ Recessive Lethal ให้ถูกต้องด้วยครับ');
                    exit;
                end;
            end
            else
            begin
                if not(le[i]=',') then
                begin
                    showmessage('กรุณากรอกช่อง Incomplete และ Recessive Lethal ให้ถูกต้องด้วยครับ');
                    exit;
                end;
            end;
        end;
    end;
  end
  else
  begin
    showmessage('กรุณากรอกช่อง Incomplete และ Recessive Lethal ให้ถูกต้องด้วยครับ');
    exit;
  end;
  //finish check
  mem.name:=gname.Text;
  mem.first:=g1.Text;
  mem.second:=g2.Text;
  mem.third:=g3.Text;
  mem.fourth:=g4.Text;
  if nowadd then
  begin
    setlength(gg,countgroup+1);
    gg[countgroup].name:=gname.text;
    gg[countgroup].first:=g1.Text;
    gg[countgroup].second:=g2.Text;
    gg[countgroup].third:=g3.Text;
    gg[countgroup].fourth:=g4.Text;
    gg[countgroup].incom:=sort(incomplete.Text);
    gg[countgroup].leth:=sort(lethal.Text);
    countgroup:=countgroup+1;
    selectgroup.Items.Add(inttostr(countgroup));
  end
  else
  begin
    gg[(strtoint(selectgroup.text))-1].name:=gname.Text;
    gg[(strtoint(selectgroup.text))-1].first:=g1.Text;
    gg[(strtoint(selectgroup.text))-1].second:=g2.Text;
    gg[(strtoint(selectgroup.text))-1].third:=g3.Text;
    gg[(strtoint(selectgroup.text))-1].fourth:=g4.Text;
    gg[(strtoint(selectgroup.text))-1].incom:=sort(incomplete.Text);
    gg[(strtoint(selectgroup.text))-1].leth:=sort(lethal.Text);
  end;
  label1.Enabled:=true;
  label2.Enabled:=true;
  label3.Enabled:=true;
  label4.Enabled:=true;
  male.Enabled:=true;
  female.Enabled:=true;
  genotype.Enabled:=true;
  phenotype.Enabled:=true;

  send.Enabled:=true;
  addgroup.Enabled:=true;
  selectadvance.Enabled:=true;
  swap.Enabled:=true;
  selectswap.Enabled:=true;
  label5.Enabled:=true;
  deletegroup.Enabled:=true;
  back.Enabled:=false;
  selectgroup.Enabled:=true;
  selectgroup.Text:='';
  nowadd:=false;

  gname.Clear;
  g1.Clear;
  g2.Clear;
  g3.Clear;
  g4.Clear;
  incomplete.Clear;
  lethal.Clear;
end;

procedure Tchecksort.selectgroupChange(Sender: TObject);
var
n : integer;
begin
    if (not(isnumber(selectgroup.Text)) or (selectgroup.Text='0')) then
    begin
        selectgroup.Text:='';
        gname.Clear;
        g1.Clear;
        g2.Clear;
        g3.Clear;
        g4.Clear;
        incomplete.Clear;
        lethal.Clear;
        showmessage('กลุ่มต้องเป็นจำนวนเต็มบวกเท่านั้น');
    end
    else if selectgroup.Text='' then
    begin
        gname.Clear;
        g1.Clear;
        g2.Clear;
        g3.Clear;
        g4.Clear;
        incomplete.Clear;
        lethal.Clear;
        exit;
    end
    else if strtoint(selectgroup.Text)<=countgroup then
    begin
        n:=(strtoint(selectgroup.Text)-1);
        gname.Text:=gg[n].name;
        g1.Text:=gg[n].first;
        g2.Text:=gg[n].second;
        g3.Text:=gg[n].third;
        g4.Text:=gg[n].fourth;
        incomplete.Text:=gg[n].incom;
        lethal.Text:=gg[n].leth;
    end

    else
    begin
        gname.Clear;
        g1.Clear;
        g2.Clear;
        g3.Clear;
        g4.Clear;
        incomplete.Clear;
        lethal.Clear;
        selectgroup.Text:='';
        showmessage('ไม่มีกลุ่มที่คุณต้องการดู');
    end;
end;

procedure Tchecksort.swapClick(Sender: TObject);
var
mem :gene;
n,s,l,i,x :integer;
j :char;
str :string;
begin
    str:=selectswap.Text;

    if ((str='') or (selectgroup.text='')) then exit;

    l:=length(str);
    for i:=1 to l do
    begin
        x:=0;
        for j:='0' to '9' do
        begin
            if str[i]=j then
                x:=x+1;
        end;
        if x=0 then
        begin
            showmessage('กลุ่มที่จะสลับต้องเป็นตัวเลขเท่านั้น');
            exit;
        end;
    end;

    if strtoint(selectswap.Text)>countgroup then
    begin
        showmessage('ไม่มีกลุ่มที่ '+selectswap.Text+' สำหรับสลับนะครับ');
        exit;
    end;
    n:=strtoint(selectgroup.Text)-1;
    s:=strtoint(selectswap.Text)-1;
    mem:=gg[n];
    gg[n]:=gg[s];
    gg[s]:=mem;
    selectgroup.text:=selectswap.Text;
end;

procedure Tchecksort.DeleteGroupClick(Sender: TObject);
var
n,i :integer;
begin
    if selectgroup.Text='' then exit;
    
    n:=strtoint(selectgroup.Text)-1;
    selectgroup.Items.Delete(countgroup-1);
    for i:=n to countgroup-2 do
    begin
        gg[i]:=gg[i+1];
    end;
    countgroup:=countgroup-1;
    setlength(gg,countgroup);

    selectgroup.Text:='';
    gname.Clear;
    g1.Clear;
    g2.Clear;
    g3.Clear;
    g4.Clear;
    incomplete.Clear;
    lethal.Clear;
end;

procedure Tchecksort.selectswapChange(Sender: TObject);
begin
    if ((not(isnumber(selectswap.Text))) or (selectswap.Text='0')) then
    begin
        selectswap.Text:='';
        showmessage('กลุ่มต้องเป็นจำนวนเต็มบวกเท่านั้น');
        exit;
    end;
end;

end.
