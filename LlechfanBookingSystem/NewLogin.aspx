<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NewLogin.aspx.cs" Inherits="LlechfanBookingSystem.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Page</title>
    <link rel="stylesheet" type="text/css" href="Css/Llechfan.css"/>
</head>

<body>
    <form id="form1" runat="server">
        <div class="container">
        <img src="Images/talyllynTrain.jpg" />
            
            <div class="header">
                <asp:Label ID="lblLlechfanHostel" runat="server" Text="Llechfan Hostel" CssClass="lblTitleStyle"></asp:Label>
                <br />
                <asp:Label ID="lblLoginPage" runat="server" Text="Login Page" CssClass="lblStyle"></asp:Label>
                <br />   
            </div>
            <br />
            <center>
            <asp:TextBox ID="txtMemID" CssClass="input" runat="server" placeholder="Enter Membership ID" MaxLength="6"></asp:TextBox><br />
            <asp:TextBox ID="txtPassword" CssClass="input" runat="server" type="password" placeholder="Enter Password" MaxLength="15"></asp:TextBox>
            </center>    
            <br />
            <asp:Button ID="btnLogin" CssClass="btnStyle" runat="server" OnClick="btnLogin_Click" Text="Login" Font-Names="Arial" />
            <asp:Button ID="Button1" CssClass="btnStyle" runat="server" OnClick="Button1_Click" Text="Register" Font-Names="Arial" Font-Overline="False" Font-Strikeout="False" />
            <br />        
        </div>    
    </form>
</body>
</html>