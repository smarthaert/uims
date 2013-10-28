//////////////////////////////////////////////////////////////////////////////
//
//	Unit:         AVLTree
//               AVL-Tree implementation
//
//
//////////////////////////////////////////////////////////////////////////////
//
//     Copyright (c) 2004-2011 NikaSoft. All rights reserved.
//     Author: A.V.Nikulitsa
//
//       site: http://www.nika-soft.com/ 
//     e-mail: support@nika-soft.com
//
//////////////////////////////////////////////////////////////////////////////
unit avltree;

{$Q-}
{$R-}

interface

Type

TAVLNode = class
private
  FKey: Longint;
  FRight: TAVLNode;
  FLeft: TAVLNode;
  FBal: shortint;
  property Bal: Shortint read FBal write FBal;
public
  constructor Create(AKey: Longint);
  property Key: Longint read FKey;
end;

TAVLTree = class
private
  FCurKey: Longint;
  FCurNode: TAVLNode;
  FNodeCount: Longint;
  FRoot: TAVLNode;  
  procedure BalanceNode(var curnode: TAVLNode; dbal: integer);
  function InternalDeleteNode(Var curnode: TAVLNode; AKey: Longint; var delnode: TAVLNode): integer;
  function InternalDeleteNearestNode(Var curnode: TAVLNode;
           direction:integer; var delnode: TAVLNode): integer;
  procedure FreeNode(ANode: TAVLNode);
  function InternalGetOrCreateNode(Var ANode: TAVLNode; 
           AKey: Longint; var opt: byte): TAVLNode;
  procedure CheckBalance(ANode: TAVLNode);
  function  GetHeight(ANode: TAVLNode): integer;
public
  constructor Create();
  destructor Destroy(); override;
  function GetNode(AKey: Longint): TAVLNode;
  function GetNodeNext(AKey: Longint): TAVLNode;
  function GetNodePrev(AKey: Longint): TAVLNode;
  function GetNodeGE(AKey: Longint): TAVLNode;
  function GetNodeLE(AKey: Longint): TAVLNode;
  function GetOrCreateNode(AKey: Longint): TAVLNode;
  function NodeExists(AKey: Longint): boolean;
  function DeleteNode(AKey: Longint): TAVLNode;
  function NodeCreate(AKey: Longint): TAVLNode; virtual;
  procedure NodeCreated(ANode: TAVLNode); virtual;
  procedure NodeDeleted(ANode: TAVLNode); virtual;
  property Count: Longint read FNodeCount;
end;

implementation

constructor TAVLTree.Create();
begin
  inherited Create;
  FCurKey := -1;
  FCurNode := nil;
  FRoot := nil;
end;

procedure TAVLTree.FreeNode(ANode: TAVLNode);
begin
  if Assigned(ANode) then begin
     if Assigned(ANode.FLeft) then begin
        FreeNode(ANode.FLeft);
     end;
     if Assigned(ANode.FRight) then begin
        FreeNode(ANode.FRight);
     end;
     ANode.Free();
  end;
end;

function TAVLTree.NodeCreate(AKey: Longint): TAVLNode;
begin
   Result := TAVLNode.Create(AKey);
   FCurKey := AKey;
   FCurNode := Result;
end;

destructor TAVLTree.Destroy();
begin
   inherited Destroy;
   FreeNode(FRoot);
end;

function TAVLTree.GetNode(AKey: Longint): TAVLNode;
begin
  if AKey = FCurKey then begin
     Result := FCurNode;
  end else begin
     Result := FRoot;
     while Assigned(Result) do begin
        if Result.Key = AKey then begin
           break;
        end else if AKey > Result.Key then begin
           Result := Result.FRight;
        end else begin
           Result := Result.FLeft;
        end;
     end;

     if Assigned(Result) then begin
        FCurKey := AKey;
        FCurNode := Result;
     end;
  end;
end;

function TAVLTree.GetNodeGE(AKey: Longint): TAVLNode;
var n: TAVLNode;
begin
  n := FRoot;
  Result := nil;
  while Assigned(n) do begin
     if n.Key = AKey then begin
        Result := n;
        break;
     end else if AKey > n.Key then begin
        n := n.FRight;
     end else begin
        Result := n;
        n := n.FLeft;
     end;
  end;
end;

function TAVLTree.GetNodeLE(AKey: Longint): TAVLNode;
var n: TAVLNode;
begin
  n := FRoot;
  Result := nil;
  while Assigned(n) do begin
     if n.Key = AKey then begin
        Result := n;
        break;
     end else if AKey > n.Key then begin
        Result := n;
        n := n.FRight;
     end else begin
        n := n.FLeft;
     end;
  end;
end;

function TAVLTree.GetNodeNext(AKey: Longint): TAVLNode;
var n: TAVLNode;
begin
  n := FRoot;
  Result := nil;
  while Assigned(n) do begin
     if n.Key <= AKey then begin
        n := n.FRight;
     end else begin
        Result := n;
        n := n.FLeft;
     end;
  end;
end;

function TAVLTree.GetNodePrev(AKey: Longint): TAVLNode;
var n: TAVLNode;
begin
  n := FRoot;
  Result := nil;
  while Assigned(n) do begin
     if n.Key >= AKey then begin
        n := n.FLeft;
     end else begin
        Result := n;
        n := n.FRight;
     end;
  end;
end;

procedure TAVLTree.BalanceNode(var curnode: TAVLNode; dbal: integer);
var
   newbal: integer;
   childnode: TAVLNode;
begin
   newbal := curnode.Bal + dbal;
   case newbal of 
      -2: begin
            //need to rotate right
            if curnode.FRight.Bal = 1 then begin
               //double right rotate
               //
               //      a              c   
               //     / \            / \
               //    l   b   -->    a   b
               //       / \        / \ / \
               //      c   r      l  m n  r
               //     / \      
               //    m   n  
               // a=curnode; b=childnode
               {a.FRight = m }
               childnode := curnode.FRight;
               curnode.FRight := childnode.FLeft.FLeft; 
               {c.FLeft = a}
               childnode.FLeft.FLeft := curnode;
               {curnode = c}
               curnode := childnode.FLeft; 
               {b.FLeft = n}
               childnode.FLeft := curnode.FRight;
               {c.FRight = b}
               curnode.FRight := childnode;
               //set Balance
               case curnode.Bal of
                  0:  begin
                        curnode.FLeft.Bal := 0;
                        childnode.Bal    := 0;
                      end;
                  1:  begin
                        curnode.FLeft.Bal := 0;
                        childnode.Bal    := -1;
                      end;
                 -1:  begin
                        curnode.FLeft.Bal := 1;
                        childnode.Bal    := 0;
                      end;
               end;
               curnode.Bal := 0; {c.Balance = 0}
            end else begin
               //single right rotate
               //      a              b   
               //     / \            / \
               //    l   b   -->    a   r
               //       / \        / \ 
               //      c   r      l   c 
               // a=curnode; b=childnode
               childnode := curnode.FRight;
               curnode.FRight := childnode.FLeft; {a.FRight = c}
               childnode.FLeft := curnode; {b.FLeft = a}
               curnode := childnode;
               //set Balance
               if curnode.Bal = 0 then begin
                  curnode.Bal := 1;
                  curnode.FLeft.Bal := -1;
               end else begin
                  curnode.Bal := 0;
                  curnode.FLeft.Bal := 0;
               end;
            end;
          end;
      -1: begin
            curnode.Bal := newbal;
          end;
       0: begin
            curnode.Bal := newbal;
          end;
       1: begin
            curnode.Bal := newbal;
          end;
       2: begin
            //rotate left
            if curnode.FLeft.Bal = -1 then begin
               //double left rotate
               //
               //      a              c   
               //     / \            / \
               //    b   r   -->    b   a
               //   / \            / \ / \
               //  l   c          l  m n  r
               //     / \      
               //    m   n  
               // a=curnode; b=childnode
               childnode := curnode.FLeft;
               {a.FLeft = n }
               curnode.FLeft := childnode.FRight.FRight; 
               {c.FRight = a}
               childnode.FRight.FRight := curnode;
               {curnode = c}
               curnode := childnode.FRight; 
               {b.FRight = m}
               childnode.FRight := curnode.FLeft;
               {c.FLeft = b}
               curnode.FLeft := childnode;
               //set Balance
               case curnode.Bal of
                 0:  begin
                       curnode.FRight.Bal := 0;
                       childnode.Bal    := 0;
                     end;
                 1:  begin
                       curnode.FRight.Bal := -1;
                       childnode.Bal    := 0;
                     end;
                -1:  begin
                       curnode.FRight.Bal := 0;
                       childnode.Bal    := 1;
                     end;
               end;
               curnode.Bal := 0; {c.Balance = 0}
            end else begin
               //single left rotate
               //      a              b   
               //     / \            / \
               //    b   r   -->    l   a
               //   / \                / \ 
               //  l   c              c   r
               // a=curnode; b=childnode
               childnode := curnode.FLeft;
               curnode.FLeft := childnode.FRight; {a.FLeft = c}
               childnode.FRight := curnode; {b.FRight = a}
               curnode := childnode;
               //set Balance
               if curnode.Bal = 0 then begin
                  curnode.Bal := -1;
                  curnode.FRight.Bal := 1;
               end else begin
                  curnode.Bal := 0;
                  curnode.FRight.Bal := 0;
               end;
            end;
          end;
   end;
end;
       
function TAVLTree.InternalDeleteNearestNode(Var curnode: TAVLNode;
   direction: integer; var delnode: TAVLNode): integer;
begin
   Result := 0;
   case direction of
      1: begin
           if Assigned(curnode.FRight) then begin
              Result := InternalDeleteNearestNode(curnode.FRight,
                 direction, delnode);
              if Result = 1 then begin
                 BalanceNode(curnode, +1);
                 if curnode.Bal <> 0 then begin
                    Result := 0;
                 end;
              end;
           end else begin
              delnode := curnode;
              curnode := curnode.FLeft;
              Result := 1;
           end;
         end;
     -1: begin
           if Assigned(curnode.FLeft) then begin
              Result := InternalDeleteNearestNode(curnode.FLeft,
                 direction, delnode);
              if Result = 1 then begin
                 BalanceNode(curnode, -1);
                 if curnode.Bal <> 0 then begin
                    Result := 0;
                 end;
              end;
           end else begin
              delnode := curnode;
              curnode := curnode.FRight;
              Result := 1;
           end;
         end;
   end;
end;

function TAVLTree.InternalDeleteNode(Var curnode: TAVLNode; AKey:
   Longint; var delnode: TAVLNode): integer;
var 
   nearestnode: TAVLNode;
   dbal: integer;
begin
   if not(Assigned(curnode)) then begin
      //node is not found
      delnode := nil;
      Result := 0;
   end else begin
      if AKey = curnode.Key then begin
         delnode := curnode;
         if Assigned(curnode.FLeft) and 
            Assigned(curnode.FRight) then begin
            //has both subtree
            dbal := 0;
            if curnode.Bal = 1 then begin
               Result := InternalDeleteNearestNode(curnode.FLeft, 1, nearestnode);
               if Result = 1 then dbal := -1;
            end else begin
               Result := InternalDeleteNearestNode(curnode.FRight, -1, nearestnode);
               if Result = 1 then dbal := 1;
            end;
            nearestnode.Bal := curnode.Bal;
            nearestnode.FLeft := curnode.FLeft;
            nearestnode.FRight := curnode.FRight;
            curnode := nearestnode;
            nearestnode := nil;
            if Result = 1 then begin
                BalanceNode(curnode, dbal);
                //         curnode.Bal = dbal,',', curnode.Bal <> 0,')');
                if curnode.Bal <> 0 then begin
                    Result := 0;
                end;
             end;

         end else if not(Assigned(curnode.FLeft)) and
                     not(Assigned(curnode.FRight)) then begin
            //is leaf
            //need to keep curnode
            delnode := curnode;
            curnode := nil;
            Result := 1;
         end else if Assigned(curnode.FLeft) then begin
            //has only left subtree
            //need to keep curnode
            delnode := curnode;
            curnode := curnode.FLeft;
            Result := 1;
         end else begin
            //has only right subtree
            //need to keep curnode
            delnode := curnode;
            curnode := curnode.FRight;
            Result := 1;
         end;
      end else if AKey > curnode.Key then begin
         Result := InternalDeleteNode(curnode.FRight, AKey, delnode); 
         if Result = 1 then begin
            BalanceNode(curnode, +1);
            if curnode.Bal <> 0 then begin
               Result := 0;
            end;
         end;
      end else begin
         Result := InternalDeleteNode(curnode.FLeft, AKey,  delnode); 
         if Result = 1 then begin
            BalanceNode(curnode, -1);
            if curnode.Bal <> 0 then begin
               Result := 0;
            end;
         end;
      end;
   end;
end;

function TAVLTree.DeleteNode(AKey: Longint): TAVLNode;
begin
   Result := nil;
   InternalDeleteNode(FRoot, AKey, Result);
   if Assigned(Result) then begin
      Result.FLeft := nil;
      Result.FRight := nil;
      Dec(FNodeCount);
      if AKey = FCurKey then begin
         FCurKey := -1;
         FCurNode := nil;
      end;
      NodeDeleted(Result);
      //CheckBalance(FRoot);
   end;
end;


function TAVLTree.InternalGetOrCreateNode(Var ANode: TAVLNode; 
   AKey: Longint; var opt: byte): TAVLNode;
begin
   if Assigned(ANode) then begin
      if ANode.Key = AKey then begin
         Result := ANode;
         opt := $00; //node is not new and no need to rebalance
      end else if AKey > ANode.Key then begin
         Result := InternalGetOrCreateNode(ANode.FRight, AKey, opt);
         if (opt and $01) = $01 then begin
            BalanceNode(ANode, -1);
            if ANode.Bal = 0 then begin
               opt := opt and $FE; //no need to rebalance
            end;
         end;
      end else begin
         Result := InternalGetOrCreateNode(ANode.FLeft, AKey, opt);
         if (opt and $01) = $01 then begin
            BalanceNode(ANode, +1);
            if ANode.Bal = 0 then begin
               opt := opt and $FE; //no need to rebalance
            end;
         end;
      end;
   end else begin
      ANode := NodeCreate(AKey); 
      Result := ANode;
      opt := opt or $03; //node is new and need to rebalance
   end;
end;

procedure TAVLTree.NodeCreated(ANode: TAVLNode);
begin
end;

procedure TAVLTree.NodeDeleted(ANode: TAVLNode);
begin
end;

function TAVLTree.GetOrCreateNode(AKey: Longint): TAVLNode;
var opt: byte;
begin
   if FCurKey = AKey then begin
      Result := FCurNode;
   end else begin
      opt := $00;
      Result := InternalGetOrCreateNode(FRoot, AKey, opt);
      if (opt and $02) = $02 then begin
         //new node
         FNodeCount := FNodeCount + 1;
         NodeCreated(Result);
         //CheckBalance(FRoot);
         //event
      end;
      if Assigned(Result) then begin
         FCurKey := AKey;
         FCurNode := Result;
      end;
   end;
end;

function TAVLTree.NodeExists(AKey: Longint): boolean;
begin
   Result := Assigned(GetNode(AKey));
end;

constructor TAVLNode.Create(AKey: Longint);
begin
   inherited Create;
   FKey := AKey;
   FBal := 0;
end;

function  TAVLTree.GetHeight(ANode: TAVLNode): integer;
var l: integer;
begin
   if not(Assigned(ANode)) then begin
      Result := 0;
   end else begin
      Result := GetHeight(ANode.FRight);
      l := GetHeight(ANode.FLeft);
      if Result < l then Result := l;
      Result := Result + 1;
   end;
end;

procedure TAVLTree.CheckBalance(ANode: TAVLNode);
var l, r: integer;
begin
   if Assigned(ANode) then begin
      l := GetHeight(ANode.FLeft);
      r := GetHeight(ANode.FRight);
      if ANode.Bal <> (l-r) then begin
         //...
      end;
      CheckBalance(ANode.FLeft);
      CheckBalance(ANode.FRight);
   end;
end;

end.
