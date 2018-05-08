<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="LlechfanBookingSystem.Register" %>
<%@ Register assembly="BasicFrame.WebControls.BasicDatePicker" namespace="BasicFrame.WebControls" tagprefix="BDP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
    <link rel="stylesheet" type="text/css" href="Css/Llechfan.css"/>
    <style type="text/css">
        .auto-style1 {
            width: 300px;
            text-align: left;
            height: 45px;
        }
        .auto-style2 {
            width: 199px;
        }
        .auto-style8 {
            width: 199px;
            height: 23px;
        }
        .auto-style9 {
            text-align: left;
            height: 23px;
        }
        .auto-style11 {
            width: 199px;
            height: 12px;
        }
        .auto-style12 {
            text-align: left;
            height: 12px;
        }
        .auto-style16 {
            text-align: left;
        }
        .auto-style18 {
            width: 199px;
            height: 45px;
        }
        .auto-style19 {
            text-align: right;
            width: 476px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="TitleContainer">
        <asp:Label ID="lblRegisterTitle" runat="server" CssClass="lblTitleStyle" Text="Register User"></asp:Label>
        </div>
    <div class="container">
        <table class="registerTable">
            <tr>
                <td class="auto-style19">
                    <asp:Label ID="lblMembershipID" runat="server" class="lblSmallStyle" Text="Enter Membership ID:"></asp:Label>
                    </td>
                <td class="auto-style2"><asp:TextBox ID="txtMembershipID" runat="server" CssClass="input" MaxLength="6"></asp:TextBox></td>
                <td class="auto-style16">
                    <asp:RequiredFieldValidator ID="rqfvMembershipID" runat="server" ControlToValidate="txtMembershipID" ErrorMessage="Please Enter Membership ID" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:Label ID="lblMemberIDem" runat="server" ForeColor="Red" Text="ErrorMessage" Visible="False"></asp:Label></td>
            </tr>
            <tr>
                <td class="auto-style19">
                    <asp:Label ID="lblTitle" runat="server" class="lblSmallStyle" Text="Select Title:"></asp:Label>
                    </td>
                <td class="auto-style2"><asp:DropDownList ID="drptxtTitle" runat="server" CssClass="input">
                    <asp:ListItem>Select Title</asp:ListItem>
                    <asp:ListItem>Mr</asp:ListItem>
                    <asp:ListItem>Mrs</asp:ListItem>
                    <asp:ListItem>Ms</asp:ListItem>
                    <asp:ListItem>Miss</asp:ListItem>
                   </asp:DropDownList></td>
                <td class="auto-style16"><asp:RequiredFieldValidator ID="rqfvTitle" runat="server" ControlToValidate="drptxtTitle" ErrorMessage="Please Enter Title" ForeColor="Red" InitialValue="Select Title">*</asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="auto-style19">
                    <asp:Label ID="lblFirstname" runat="server" class="lblSmallStyle" Text="Enter First Name:"></asp:Label>
                   </td>
                <td class="auto-style18"><asp:TextBox ID="txtFirstname" runat="server" CssClass="input"></asp:TextBox></td>
                <td class="auto-style1"><asp:RequiredFieldValidator ID="rqfvFirstname" runat="server" ControlToValidate="txtFirstname" ErrorMessage="Please Enter First Name" ForeColor="Red">*</asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="auto-style19">
                    <asp:Label ID="lblSurname" runat="server" class="lblSmallStyle" Text="Enter Last Name:"></asp:Label>
                   </td>
                <td class="auto-style2"><asp:TextBox ID="txtSurname" runat="server" CssClass="input"></asp:TextBox></td>
                <td class="auto-style16"><asp:RequiredFieldValidator ID="rqfvSurname" runat="server" ControlToValidate="txtSurname" ErrorMessage="Please Enter Last Name" ForeColor="Red">*</asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="auto-style19">
                    <asp:Label ID="lblEmailAddress" runat="server" class="lblSmallStyle" Text="Enter Email Address:"></asp:Label>
                   </td>
                <td class="auto-style2"><asp:TextBox ID="txtEmailAddress" runat="server" TextMode="Email" CssClass="input"></asp:TextBox></td>
                <td class="auto-style16">
                    <asp:RequiredFieldValidator ID="rqfvEmailAddress" runat="server" ControlToValidate="txtEmailAddress" ErrorMessage="Please Enter Email Address" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmailAddress" runat="server" ControlToValidate="txtEmailAddress" ErrorMessage="*Invalid Email Address" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator></td>
            </tr>
            <tr>
                <td class="auto-style19">
                    <asp:Label ID="lblDOB" runat="server" class="lblSmallStyle" Text="Select Date Of Birth:"></asp:Label>
                    </td>
                <td class="auto-style11">
        
          <BDP:BasicDatePicker ID="dateCheckIn" runat="server" DateFormat="dd-MM-yyyy" OnSelectionChanged="BasicDatePicker1_SelectionChanged" SelectedDate="2017-04-24" />
           
                </td>
                <td class="auto-style12">
                    <asp:RequiredFieldValidator ID="rqfvDOB" runat="server" ControlToValidate="dateCheckIn" ErrorMessage="Please Enter Date Of Birth" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="rvDOB" runat="server" ControlToValidate="dateCheckIn" ErrorMessage="*Invalid Date Of Birth" MinimumValue="01/01/1900" Type="Date" ForeColor="Red"></asp:RangeValidator>
                    </td>
            </tr>
            <tr>
                <td class="auto-style19">
                    <asp:Label ID="lblGender" runat="server" class="lblSmallStyle" Text="Select Gender:"></asp:Label>
                   </td>
                <td class="auto-style8"><asp:DropDownList ID="drptxtGender" runat="server" CssClass="input">
                    <asp:ListItem Value="Select Gender">Select Gender</asp:ListItem>
                    <asp:ListItem>Male</asp:ListItem>
                    <asp:ListItem>Female</asp:ListItem>
                   </asp:DropDownList></td>
                <td class="auto-style9"><asp:RequiredFieldValidator ID="rqfvGender" runat="server" ControlToValidate="drptxtGender" ErrorMessage="Please Enter Gender" ForeColor="Red" InitialValue="Select Gender">*</asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="auto-style19">
                    <asp:Label ID="lblPhoneNumber" runat="server" class="lblSmallStyle" Text="Enter Phone Number:"></asp:Label>
                    </td>
                <td class="auto-style2"><asp:TextBox ID="txtPhoneNumber" runat="server" CssClass="input" MaxLength="11"></asp:TextBox></td>
                <td class="auto-style16"><asp:RequiredFieldValidator ID="rqfvPhoneNumber" runat="server" ControlToValidate="txtPhoneNumber" ErrorMessage="Please Enter A Phone Number" ForeColor="Red">*</asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="auto-style19">
                    <asp:Label ID="lblPassword" runat="server" class="lblSmallStyle" Text="Enter Password:"></asp:Label>
                    </td>
                <td class="auto-style2"><asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="input" MaxLength="15"></asp:TextBox></td>
                <td class="auto-style16"><asp:RequiredFieldValidator ID="rqfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Please Enter Password" ForeColor="Red">*</asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td class="auto-style19">
                    <asp:Label ID="lblCPassword" runat="server" class="lblSmallStyle" Text="Confirm Password:"></asp:Label>
                    </td>
                <td class="auto-style2"><asp:TextBox ID="txtConPassword" runat="server" TextMode="Password" CssClass="input" MaxLength="15"></asp:TextBox></td>
                <td class="auto-style16">
                    <asp:RequiredFieldValidator ID="rqfvCpassword" runat="server" ControlToValidate="txtConPassword" ErrorMessage="Please Re-Enter Password" ForeColor="Red">*</asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cmpvCpassword" runat="server" ControlToCompare="txtPassword" ControlToValidate="txtConPassword" ErrorMessage="*Passwords Don't Match" ForeColor="Red"></asp:CompareValidator></td>
            </tr>    
        </table>

        <hr />
        <asp:Button ID="btnSubmit" class="btnStyle" runat="server" OnClick="btnSubmit_Click" Text="Submit"/>
        <br />
        <asp:Label ID="lblReturnMainMenu" runat="server" class="lblSmallStyle" Text="Return to the login Screen:"></asp:Label>
        <br />
        <asp:Button ID="btnLoginScreen" class="btnStyle" runat="server"  OnClick="btnLoginScreen_Click" Text="Back" CausesValidation="false"/>
        <br />
    </div>
    </form>
</body>
</html>
