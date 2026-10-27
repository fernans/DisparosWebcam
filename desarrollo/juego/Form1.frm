VERSION 5.00
Object = "{D27CDB6B-AE6D-11CF-96B8-444553540000}#1.0#0"; "FlDbg9c.ocx"
Begin VB.Form Form1 
   BorderStyle     =   0  'None
   Caption         =   "Dibujar"
   ClientHeight    =   3090
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   4680
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3090
   ScaleWidth      =   4680
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.PictureBox Picture1 
      Height          =   615
      Left            =   1920
      ScaleHeight     =   555
      ScaleWidth      =   555
      TabIndex        =   1
      Top             =   120
      Visible         =   0   'False
      Width           =   615
   End
   Begin ShockwaveFlashObjectsCtl.ShockwaveFlash Flash1 
      Height          =   615
      Left            =   1080
      TabIndex        =   0
      Top             =   120
      Width           =   615
      _cx             =   1085
      _cy             =   1085
      FlashVars       =   ""
      Movie           =   ""
      Src             =   ""
      WMode           =   "Window"
      Play            =   -1  'True
      Loop            =   -1  'True
      Quality         =   "High"
      SAlign          =   ""
      Menu            =   -1  'True
      Base            =   ""
      AllowScriptAccess=   ""
      Scale           =   "ShowAll"
      DeviceFont      =   0   'False
      EmbedMovie      =   0   'False
      BGColor         =   ""
      SWRemote        =   ""
      MovieData       =   ""
      SeamlessTabbing =   -1  'True
      Profile         =   -1  'True
      ProfileAddress  =   ""
      ProfilePort     =   1162363743
      AllowNetworking =   "all"
      AllowFullScreen =   "false"
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Const CropX = 240
Const CropY = 170
Const CropXf = 575
Const CropYf = 525
Const DestW = (CropXf - CropX) * 2.9
Const DestH = (CropYf - CropY) * 2.9
Const DestX = 1000
Const DestY = 1600
Const Alpha = 255


'Private Declare Sub Sleep Lib "kernel32" (ByVal milliseconds As Long)
Dim fs As Scripting.FileSystemObject
Dim fol As Scripting.Folder
Dim nfiles As Long
Dim findex As Long
Dim fnames() As String
'Variable para usar la dll
Dim Capture As CaptureWindow


Private Sub Flash1_FSCommand(ByVal command As String, ByVal args As String)
    If (command = "SALIR") Then End
    If (command = "FIRST") Then
        'MsgBox "First"
        findex = 1
    End If
    If (command = "NEXT") Then
        'MsgBox "Next"
        findex = findex + 1
        If (findex > nfiles) Then findex = 1
    End If
    If (command = "PREV") Then
        'MsgBox "Prev"
        findex = findex - 1
        If (findex <= 0) Then findex = nfiles
    End If
    If (command = "CAPTURA") Then
        'Sleep 5000 'espera 5 segundos...
        DoEvents
        Set Picture1.Picture = Capture.CapturarCliente(Me)
        
        'Decirle al flash... que ya puede seguir...
        Flash1.Play
        
        'componer e imprimir compo.
        ComponerImagen
        
    End If
    If (command = "FIRST" Or command = "NEXT" Or command = "PREV") Then
        archivo = fnames(findex)
        'MsgBox imagen
        request = "<invoke name=" & Chr(34) & "CargarMusica" & Chr(34) & "><arguments><string>" & archivo & "</string></arguments></invoke>"
        Flash1.CallFunction request
    End If
End Sub

Private Sub Form_Load()
    Flash1.Movie = App.path & "\interfaz.swf"
    
    Set fs = CreateObject("Scripting.FileSystemObject")
    Set fol = fs.GetFolder(App.path & "\musica")
    nfiles = fol.Files.Count
    ReDim fnames(0 To nfiles)
    findex = 1
    For Each f In fol.Files
        If (fs.GetExtensionName(f.path) = "mp3") Then
            fnames(findex) = f.Name
            findex = findex + 1
        End If
    Next
    nfiles = findex - 1
    findex = 1
    If nfiles < 1 Then
        MsgBox "La carpeta 'musca' no existe, o está vacia."
        End
    End If
    Set Capture = New CaptureWindow
    Capture.AjustarPicToPage = True 'se ajusta a la hoja
End Sub

Private Sub Form_Resize()
    Flash1.Left = 0
    Flash1.Top = 0
    Flash1.Width = Me.Width
    Flash1.Height = Me.Height
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Set Capture = Nothing
End Sub

Private Sub ComponerImagen()
    On Error GoTo ErrHandle
    Dim Iplantilla As Long
    Dim iTemp As Long
    Dim Ifoto As Long
    Dim Icompo As Long
    Dim errMsg As String
    
    'abrir imagen plantilla
    errMsg = "No se ha podido leer la imagen 'plantilla.png'"
    Iplantilla = FreeImage_Load(FIF_PNG, "plantilla.png")
    
    'abrir imagen captura-webcam (Picture1.Picture)
    errMsg = "No se ha podido capturar de la webcam"
    Ifoto = FreeImage_CreateFromOlePicture(Picture1.Picture)
    
    'componer las imagenes
    Icompo = FreeImage_Clone(Iplantilla)
    'Icompo = FreeImage_Copy(Iplantilla, 0, 0, FreeImage_GetWidth(Iplantilla) - 1, FreeImage_GetHeight(Iplantilla) - 1)
    
    'errMsg = "Error conviertiendo a Blanco y Negro"
    'iTemp = FreeImage_ConvertToGreyscale(Ifoto)
    'FreeImage_Unload (Ifoto): Ifoto = iTemp

    errMsg = "Error recortando el area de imagen"
    iTemp = FreeImage_Copy(Ifoto, CLng(CropX), CLng(CropY), CLng(CropXf), CLng(CropYf))
    FreeImage_Unload (Ifoto): Ifoto = iTemp
        
    errMsg = "Error escalando el area de imagen"
    iTemp = FreeImage_Rescale(Ifoto, DestW, DestH, FILTER_BOX)
    FreeImage_Unload (Ifoto): Ifoto = iTemp

    ' COMPONER LA IMAGEN A MANO (alpha-blending)
    'errMsg = "Error componiendo imagen (webcam)"
    'If Not FreeImage_Paste(Icompo, Ifoto, CLng(DestX), CLng(DestY), 500) Then MsgBox errMsg
    
    DoEvents
    
    errMsg = "Error componiendo imagen (alfa-blending)"
    Dim w As Long, h As Long, x As Long, y As Long
    Dim c1 As RGBQUAD, c2 As RGBQUAD
    Dim alfa As Double, ialfa As Double, gris As Double
    w = FreeImage_GetWidth(Ifoto) - 1
    h = FreeImage_GetHeight(Ifoto) - 1
    For y = 0 To h
        For x = 0 To w
            FreeImage_GetPixelColor Ifoto, x, y, c1
            FreeImage_GetPixelColor Icompo, x + DestX, y + DestY, c2
            errMsg = "x=" & x & " y=" & y & vbCrLf & "alfa=" & c1.rgbReserved
            'c2.rgbBlue = 255
            'c2.rgbGreen = 255
            'c2.rgbRed = 255
            ialfa = CDbl(c2.rgbReserved) / 255
            alfa = CDbl(255 - c2.rgbReserved) / 255
            gris = CDbl(c1.rgbRed)
            c2.rgbBlue = (gris * alfa) + (CDbl(c2.rgbBlue) * ialfa)
            c2.rgbGreen = (gris * alfa) + (CDbl(c2.rgbGreen) * ialfa)
            c2.rgbRed = (gris * alfa) + (CDbl(c2.rgbRed) * ialfa)
            c2.rgbReserved = 255
            FreeImage_SetPixelColor Icompo, x + DestX, y + DestY, c2
        Next x
        DoEvents
    Next y
    
    
    'guardar el resultado en el picture1
    Picture1.Picture = FreeImage_GetOlePicture(Icompo)
     
    'FreeImage_Save FIF_PNG, Icompo, "temp.png"
    
    
    'Imprimir
    Capture.PrinterPicture Printer, Picture1
    
    'Vaciar Picture1
    Picture1.Cls
    
    'Todo bien
    errMsg = ""
ErrHandle:
    If (errMsg <> "") Then MsgBox "Error:" & vbCrLf & errMsg & vbCrLf & Error
    'Cerrar todo
    If Iplantilla Then FreeImage_Unload Iplantilla
    If Ifoto Then FreeImage_Unload Ifoto
    If Icompo Then FreeImage_Unload Icompo
    'If iTemp Then FreeImage_Unload iTemp
End Sub
