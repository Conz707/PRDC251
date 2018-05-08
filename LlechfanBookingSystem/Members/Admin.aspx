<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="LlechfanBookingSystem.Members.Admin" %>

<META http-equiv="Page-Exit" CONTENT="progid:DXImageTransform.Microsoft.Iris(irisstyle='SQUARE', motion='in') " />

<%@ Register assembly="BasicFrame.WebControls.BasicDatePicker" namespace="BasicFrame.WebControls" tagprefix="BDP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home Page</title>
    <link rel="stylesheet" type="text/css" href="~/Css/Llechfan.css" />
    <style type="text/css">
        #form1 {
            text-align: center;
        }
        .auto-style13 {
            width: 86%;
            height: 159px;
            margin-right: 0px;
            margin-bottom: 0px;
        }
        .auto-style32 {
            width: 799px;
            text-align: right;
            height: 17px;
        }
        .auto-style19 {
            text-align: left;
            width: 259px;
            height: 17px;
        }
        .auto-style20 {
            text-align: left;
            width: 423px;
            height: 17px;
        }
        .auto-style29 {
            width: 799px;
            text-align: right;
            height: 22px;
        }
        .auto-style30 {
            text-align: left;
            width: 259px;
            height: 22px;
        }
        .auto-style31 {
            text-align: left;
            width: 423px;
            height: 22px;
        }
        .auto-style28 {
            width: 799px;
            text-align: right;
            height: 27px;
        }
        .auto-style25 {
            text-align: left;
            width: 259px;
            height: 27px;
        }
        .auto-style26 {
            text-align: left;
            width: 423px;
            height: 27px;
        }
        .auto-style7 {
            width: 175px;
        }
        .auto-style33 {
            width: 799px;
            text-align: right;
            height: 44px;
        }
        .auto-style34 {
            text-align: left;
            width: 259px;
            height: 44px;
        }
        .auto-style35 {
            text-align: left;
            width: 423px;
            height: 44px;
        }
        </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="TitleContainer">
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblAdminPage" runat="server" Text="Admin Page"></asp:Label>

            <asp:Button ID="btnLogout" runat="server" class="btnLogoutStyle" OnClick="btnLogOut_Click" Text="Log Out" CausesValidation="False" />
            <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblWelcome" runat="server" Text="Welcome.."></asp:Label>
        </div>

        
        <div runat="server" id="divAdminMenu" class="MenuButtonsContainer">
            <asp:Button ID="btnCurrentVisitors" runat="server" class="btnMenuStyle" OnClick="btnCurrentVisitors_Click" Text="Current Visitors" />
            <asp:Button ID="btnAllBookings" runat="server" class="btnMenuStyle" OnClick="btnAllBookings_Click" Text="All Bookings" />
            <asp:Button ID="btnAllActiveAccounts" runat="server" class="btnMenuStyle" OnClick="btnAllActiveAccounts_Click" Text="Active Users" />
        </div>


        <div runat="server" id="divCurrentBookings" class="container" visible="false">
            <br />
            <asp:Label ID="lblCurrentBookings" CssClass="lblSmallStyle" runat="server" Text="Bookings Currently Taking Place:"></asp:Label>
            <br />
            <center>            
                <asp:GridView ID="grdTable" runat="server" DataSourceID="SqlDataSource1" DataKeyNames="BookingNumber" CellPadding="4" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="grdTable_SelectedIndexChanged" AutoGenerateColumns="False" style="text-align: center">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="BookingNumber" HeaderText="Booking Number" ReadOnly="True" SortExpression="BookingNumber" />
                        <asp:BoundField DataField="MemberID" HeaderText="Membership ID" SortExpression="MemberID" />
                        <asp:BoundField DataField="CheckInDate" HeaderText="Check In Date" SortExpression="CheckInDate" DataFormatString="{0:d-MMM-yyyy}" />
                        <asp:BoundField DataField="CheckOutDate" HeaderText="Check Out Date" SortExpression="CheckOutDate" DataFormatString="{0:d-MMM-yyyy}" />
                        <asp:BoundField DataField="Guests" HeaderText="Guests" SortExpression="Guests" />
                        <asp:BoundField DataField="colourRoom" HeaderText="Room Colour" SortExpression="colourRoom" />
                        <asp:BoundField DataField="StandardPrice" HeaderText="Standard Price" SortExpression="StandardPrice" DataFormatString="{0:c0}" />
                        <asp:BoundField DataField="VolunteerPrice" HeaderText="Volunteer Price" SortExpression="VolunteerPrice" DataFormatString="{0:c0}" />
                    
                    <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnActiveBookingsEdit" runat="server" CausesValidation="False" OnClick="btnActiveBookingsEdit_Click" Text="Edit"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                    <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnDeleteActiveBooking" runat="server" CausesValidation="False" OnClientClick="return confirm('Are you sure you would like to delete this? This action cannot be undone.');" CommandName="Delete" Text="Delete" OnClick="btnDeleteActiveBooking_Click"></asp:LinkButton>
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

                        <br />
                        
            <asp:Label ID="lblUnder18Visitors" CssClass="lblSmallStyle" runat="server" Text="Under 18 Curretly Staying In The Hostel:"></asp:Label>        
            <br />
            <center>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="MembershipID" DataSourceID="SqlDataSource3" CellPadding="4" ForeColor="#333333" GridLines="None" style="text-align: center">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="MembershipID" HeaderText="Membership ID" ReadOnly="True" SortExpression="MembershipID" />
                            <asp:BoundField DataField="Title" HeaderText="Title" SortExpression="Title" />
                            <asp:BoundField DataField="Firstname" HeaderText="Firstname" SortExpression="Firstname" />
                            <asp:BoundField DataField="Surname" HeaderText="Surname" SortExpression="Surname" />
                            <asp:BoundField DataField="EmailAddress" HeaderText="Email Address" SortExpression="EmailAddress" />
                            <asp:BoundField DataField="DOB" HeaderText="DOB" SortExpression="DOB" DataFormatString="{0:d-MMM-yyyy}" />
                            <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                            <asp:BoundField DataField="PhoneNumber" HeaderText="Phone Number" SortExpression="PhoneNumber" />
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
            <br />                    
                    <asp:Button ID="btnBackCurrentBookings" class="btnStyle" runat="server" OnClick="btnBackCurrentBookings_Click" Text="Back"/>

                    <br />
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" OnSelecting="SqlDataSource1_Selecting" SelectCommand="SELECT * FROM [bookings] WHERE CheckInDate < GETDATE() AND CheckOutDate > GETDATE()"  DeleteCommand="DELETE FROM bookings
WHERE BookingNumber = @BookingNumber
">
                    <DeleteParameters>
                        <asp:Parameter Name="BookingNumber" />
                    </DeleteParameters>
                    <SelectParameters>
        <asp:SessionParameter Name="id" SessionField="id" />

    </SelectParameters>

                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM [users] WHERE MembershipID IN (SELECT MemberID from [bookings] where CheckInDate < GETDATE() AND CheckOutDate > GETDATE()) AND DATEDIFF(yy, DOB, GETDATE()) < 18"></asp:SqlDataSource>
                </div>    

        <div runat="server" id="divAllBookings" class="container" visible="false">

            <br />
            <asp:Label ID="lblAdminAllBookings" CssClass="lblSmallStyle" runat="server" Text="All Current/Future Bookings:"></asp:Label>
            <br />
            <center>
            <asp:GridView ID="grdAdminAllBookings" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="BookingNumber" DataSourceID="SQLDSAdminAllBookings" ForeColor="#333333" GridLines="None" style="text-align: center">       
                <AlternatingRowStyle BackColor="White" />     
                <Columns>        
                    <asp:BoundField DataField="BookingNumber" HeaderText="Booking Number" ReadOnly="True" SortExpression="BookingNumber" />        
                    <asp:BoundField DataField="MemberID" HeaderText="Membership ID" SortExpression="MemberID" />      
                    <asp:BoundField DataField="CheckInDate" DataFormatString="{0:d-MMM-yyyy}" HeaderText="Check In Date" SortExpression="CheckInDate" />         
                    <asp:BoundField DataField="CheckOutDate" DataFormatString="{0:d-MMM-yyyy}" HeaderText="Check Out Date" SortExpression="CheckOutDate" />
                    <asp:BoundField DataField="Guests" HeaderText="Guests" SortExpression="Guests" />        
                    <asp:BoundField DataField="colourRoom" HeaderText="Room Colour" SortExpression="colourRoom" />        
                    <asp:BoundField DataField="StandardPrice" DataFormatString="{0:c0}" HeaderText="Standard Price" SortExpression="StandardPrice" HtmlEncode="False" />          
                    <asp:BoundField DataField="VolunteerPrice" DataFormatString="{0:c0}" HeaderText="Volunteer Price" SortExpression="VolunteerPrice" HtmlEncode="False" />        
                    
                    <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnActiveBookingsEdit" runat="server" CausesValidation="False" OnClick="btnActiveBookingsEdit_Click" Text="Edit"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

                    <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnDeleteActiveBooking" runat="server" CausesValidation="False" OnClientClick="return confirm('Are you sure you would like to delete this? This action cannot be undone.');" CommandName="Delete" Text="Delete" OnClick="btnDeleteActiveBooking_Click"></asp:LinkButton>
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
                <br />
                    <asp:Button ID="btnBackActiveBookings" class="btnStyle" runat="server" OnClick="btnBackActiveBookings_Click" Text="Back"/>
                <asp:SqlDataSource ID="SQLDSAdminAllBookings" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT * FROM bookings WHERE [CheckInDate] &gt;= GETDATE() " OnSelecting="SQLDSAdminAllBookings_Selecting"></asp:SqlDataSource>
        </div>

        <div runat="server" id="divEditBooking" visible="false" class="container">
        <div>
                <asp:Label ID="lblCreateBooking" runat="server" Text="Edit A Booking" CssClass="lblStyle"></asp:Label>
                <br />
            <hr />
        </div>
        <asp:Label ID="Label7" runat="server" class="lblSmallStyle" Text="Booking Number:"></asp:Label>
        &nbsp;<asp:TextBox ID="txtBookingNumber" runat="server" AutoCompleteType="Cellular" style="text-align: center" ReadOnly="True" OnTextChanged="txtBookingNumber_TextChanged"></asp:TextBox>
            <br />
            <br />
&nbsp;&nbsp;&nbsp;
        <asp:Label ID="lblMembershipID" runat="server" class="lblSmallStyle" Text="Membership ID:"></asp:Label>
        &nbsp; <asp:TextBox ID="txtMembershipID" runat="server" AutoCompleteType="Cellular" style="text-align: center" ReadOnly="True" OnTextChanged="txtBookingNumber_TextChanged"></asp:TextBox>
            <br />
            <br />
            <table align="center" class="auto-style13">
                <tr>
                    <td class="auto-style32">
        <asp:Label ID="Label9" class="lblSmallStyle" runat="server" Text="Check In Date:"></asp:Label>
                    </td>
                    <td class="auto-style19">
        
            <BDP:BasicDatePicker ID="dateCheckIn" runat="server" AutoPostBack="true"  DateFormat="dd-MM-yyyy" OnSelectionChanged="BasicDatePicker1_SelectionChanged" SelectedDate="2017-04-24" />
           
                    </td>
                    <td class="auto-style20">
           
        <asp:RangeValidator ID="validateCheckIn" runat="server" ControlToValidate="dateCheckIn" ErrorMessage="*Invalid Date Selected/Possibly Hostel Is Full" MaximumValue="28-04-3000" Type="Date" ForeColor="Red"></asp:RangeValidator>
           
                    </td>
                </tr>
                <tr>
                    <td class="auto-style29">
        <asp:Label ID="Label19" class="lblSmallStyle" runat="server" Text="Check Out Date:"></asp:Label>
                    </td>
                    <td class="auto-style30"> <BDP:BasicDatePicker ID="dateCheckOut" runat="server" AutoPostBack="true" DateFormat="dd-MM-yyyy" SelectedDate="" OnSelectionChanged="dateCheckOut_SelectionChanged" />
                    </td>
                    <td class="auto-style31">
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="dateCheckIn" ControlToValidate="dateCheckOut" ErrorMessage="*Invalid Date Selected/Possibly Hostel Is Full" Operator="GreaterThan" Type="Date" ForeColor="Red"></asp:CompareValidator>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style33">
                        <asp:Label ID="lblAdditionalGuests" class="lblSmallStyle" runat="server" Text="Additional Guests:"></asp:Label>
                    </td>
                    <td class="auto-style34"> 
                        <asp:DropDownList ID="drptxtGuests" runat="server" Height="18px" Width="114px">
                            <asp:ListItem>0</asp:ListItem>
                            <asp:ListItem>1</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>
                            <asp:ListItem>3</asp:ListItem>
                            <asp:ListItem>4</asp:ListItem>
                            <asp:ListItem>5</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style35">
                        </td>
                </tr>
                <tr>
                    <td class="auto-style28">
                        <asp:Label ID="lblRoomColour" class="lblSmallStyle" runat="server" Text="Room Colour:"></asp:Label>
                    </td>
                    <td class="auto-style25"> 
                        <asp:DropDownList ID="drptxtRoomColour" runat="server" Height="17px" Width="112px">
                            <asp:ListItem>Blue</asp:ListItem>
                            <asp:ListItem>Yellow</asp:ListItem>
                            <asp:ListItem>Green</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style26">
                        &nbsp;</td>
                </tr>
                </table>
            <br />
            <br />
            <span class="auto-style7"><span class="lblSmallStyle">Price (Per Person)</span></span><br />
            <br />
        <asp:Label ID="Label12" runat="server" class="lblSmallStyle" Text="Standard Booking Price:"></asp:Label>
        &nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtBookingPrice" runat="server" ReadOnly="True" style="text-align: center" Width="92px" OnTextChanged="txtBookingPrice_TextChanged">£10</asp:TextBox>
            &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:Label ID="Label13" runat="server" class="lblSmallStyle" Text="Volunteering Booking Price:"></asp:Label>
        &nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtVolunteerBookingPrice" runat="server" ReadOnly="True" style="text-align: center" Width="92px" OnTextChanged="txtBookingPrice_TextChanged">£3</asp:TextBox>
            <br />
            <br />
            <hr />
        <asp:Button ID="btnSaveEditing" class="btnStyle" runat="server" OnClick="btnSaveEditing_Click" Text="Save Changes"/>
        <br />
            <asp:Button ID="btnCancelEditing" class="btnStyle" runat="server" OnClick="btnCancelEditing_Click" Text="Cancel" CausesValidation="False" />
            <br />    
        </div>


    </form>
</body>
</html>

