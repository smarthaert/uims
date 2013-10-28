VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "VB示例"
   ClientHeight    =   2985
   ClientLeft      =   5295
   ClientTop       =   4125
   ClientWidth     =   7470
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2985
   ScaleWidth      =   7470
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton Command2 
      Caption         =   "重新取网卡MAC地址"
      Height          =   495
      Left            =   3840
      TabIndex        =   5
      Top             =   2040
      Width           =   2175
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   2640
      TabIndex        =   3
      Text            =   "Text1"
      Top             =   1200
      Width           =   3615
   End
   Begin VB.CommandButton Command1 
      Caption         =   "重新取CPU序列号"
      Height          =   495
      Left            =   1560
      TabIndex        =   1
      Top             =   2040
      Width           =   1935
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Left            =   2640
      TabIndex        =   0
      Text            =   "Text1"
      Top             =   600
      Width           =   3615
   End
   Begin VB.Label Label3 
      Caption         =   "注：你可在命令窗口里用ipconfig -all查到网卡MAC地址(Physical Adress)"
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   360
      TabIndex        =   6
      Top             =   1680
      Width           =   6855
   End
   Begin VB.Label Label2 
      Caption         =   "机器标识二(网卡MAC地址）"
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   1200
      Width           =   2295
   End
   Begin VB.Label Label1 
      Caption         =   "机器标识一(CPU序列号）"
      Height          =   255
      Left            =   480
      TabIndex        =   2
      Top             =   600
      Width           =   2175
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Function GetCPUSerialNumber Lib "ComputerId.dll" () As String
Private Declare Function GetMacAddress Lib "ComputerId.dll" () As String



Private Sub Command1_Click()
  Text1.Text = GetCPUSerialNumber
End Sub

Private Sub Command2_Click()
  Text2.Text = GetMacAddress
End Sub

Private Sub Form_Activate()
  Text1.Text = GetCPUSerialNumber
  Text2.Text = GetMacAddress
End Sub

