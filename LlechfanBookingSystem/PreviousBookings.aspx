<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PreviousBookings.aspx.cs" Inherits="LlechfanBookingSystem.PreviousBookings" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Previous Bookings</title>
    <link rel="stylesheet" type="text/css" href="Css/Llechfan.css"/>
</head>
<body>
    <form id="form1" runat="server">
         <div class="TitleContainer">
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Label ID="lblPreviousBookings" runat="server" Text="Previous Bookings" CssClass="lblTitleStyle"></asp:Label>
                    <asp:Button ID="btnLogout" runat="server" OnClick="btnLogOut_Click" Text="Log Out" class="btnLogoutStyle" CausesValidation="False" />
                    <br />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblWelcome" runat="server" Text="Welcome.." class="lblStyle"></asp:Label>

                </div>
            <div id="container" class="container" runat="server">
                    <br />
                <center>
                    <br />
                <asp:GridView ID="grdPreviousBookings" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="BookingNumber" DataSourceID="sqlDataPreviousBookings" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="grdTable_SelectedIndexChanged">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="BookingNumber" HeaderText="Booking Number" ReadOnly="True" SortExpression="BookingNumber" />
                        <asp:BoundField DataField="CheckInDate" HeaderText="Check In Date" SortExpression="CheckInDate" DataFormatString="{0:d-MMM-yyyy}" />
                        <asp:BoundField DataField="CheckOutDate" HeaderText="Check Out Date" SortExpression="CheckOutDate" DataFormatString="{0:d-MMM-yyyy}" />
                        <asp:BoundField DataField="Guests" HeaderText="Guests" SortExpression="Guests" />
                        <asp:BoundField DataField="colourRoom" HeaderText="Room Colour" SortExpression="colourRoom" />
                        <asp:BoundField DataField="StandardPrice" HeaderText="Standard Price" SortExpression="StandardPrice" DataFormatString="{0:c0}" />
                        <asp:BoundField DataField="VolunteerPrice" HeaderText="Volunteer Price" SortExpression="VolunteerPrice" DataFormatString="{0:c0}" />
                    </Columns>
                    <FooterStyle BackColor="#990000" ForeColor="White" Font-Bold="True" />
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
                <br />
                <asp:Button ID="PBreturnToMenu" runat="server" class="btnStyle" OnClick="PBreturnToMenu_Click" Text="Back" />
            </div>
        <asp:SqlDataSource ID="sqlDataPreviousBookings" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" OnSelecting="sqlDataPreviousBookings_Selecting" SelectCommand="SELECT [BookingNumber], [CheckInDate], [CheckOutDate], [Guests], [colourRoom], [StandardPrice], [VolunteerPrice] FROM [bookings] WHERE [CheckInDate] &lt; GETDATE() - 1 AND [MemberID] = @id">
            <SelectParameters>
                <asp:SessionParameter Name="id" SessionField="id" />
            </SelectParameters>
         </asp:SqlDataSource>
    </form>
</body>
</html>
