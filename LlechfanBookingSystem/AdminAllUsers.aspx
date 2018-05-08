<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminAllUsers.aspx.cs" Inherits="LlechfanBookingSystem.AdminAllUsers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin User Accounts</title>
    <link rel="stylesheet" type="text/css" href="Css/Llechfan.css"/>
</head>
<body>
    <form id="form1" runat="server">
    <div class="TitleContainer">    
        <asp:Label ID="lblAdminUsers" runat="server" Text="User Accounts" CssClass="lblTitleStyle"></asp:Label>            
        <asp:Button ID="btnLogout" runat="server" OnClick="btnLogOut_Click" Text="Log Out" class="btnLogoutStyle" CausesValidation="False" />
        <br />
        <asp:Label ID="lblWelcome" runat="server" Text="Welcome.." class="lblStyle"></asp:Label>
    </div>

        <div id="container" class="container" runat="server">
                <br />
            <asp:Label ID="lblActiveUsers" CssClass="lblSmallStyle" runat="server" Text="All Active Users:"></asp:Label>
            <center>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="MembershipID" DataSourceID="sqldsAdminUserAccounts" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:BoundField DataField="MembershipID" HeaderText="Membership ID" ReadOnly="True" SortExpression="MembershipID" />
                    <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                    <asp:BoundField DataField="Firstname" HeaderText="Firstname" SortExpression="Firstname" />
                    <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname" />
                    <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" SortExpression="EmailAddress" />
                    <asp:BoundField DataField="DOB" DataFormatString="{0:d-MMM-yyyy}" HeaderText="DOB" SortExpression="DOB" />
                    <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                    <asp:BoundField DataField="PhoneNumber" HeaderText="Phone Number" SortExpression="PhoneNumber" />
                
                    <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnDeleteActiveUser" runat="server" CausesValidation="False" OnClientClick="return confirm('Are you sure you would like to delete this? This action cannot be undone.');" CommandName="Delete" Text="Delete" OnClick="btnDeleteActiveUser_Click"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                <SortedAscendingCellStyle BackColor="#FDF5AC" />
                <SortedAscendingHeaderStyle BackColor="#4D0000" />
                <SortedDescendingCellStyle BackColor="#FCF6C0" />
                <SortedDescendingHeaderStyle BackColor="#820000" />
            </asp:GridView>    
            </center>
            &nbsp;<asp:Button ID="AUAreturnToMenu" runat="server" class="btnStyle" OnClick="AUAreturnToMenu_Click" Text="Back" />
        </div>

        <asp:SqlDataSource ID="sqldsAdminUserAccounts" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [users]"></asp:SqlDataSource>

    </form>
</body>
</html>
