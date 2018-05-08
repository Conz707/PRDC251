<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="LlechfanBookingSystem.HomePage" %>
<META http-equiv="Page-Exit" CONTENT="progid:DXImageTransform.Microsoft.Iris(irisstyle='SQUARE', motion='in') " />
<%@ Register assembly="BasicFrame.WebControls.BasicDatePicker" namespace="BasicFrame.WebControls" tagprefix="BDP" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home Page</title>
    <link rel="stylesheet" type="text/css" href="~/Css/Llechfan.css" />

    <style type="text/css">
        .auto-style2 {
            text-align: center;
        }
        .auto-style4 {
            width: 595px;
            height: 149px;
        }
        .auto-style7 {
            width: 175px;
        }
        .auto-style9 {
            width: 636px;
            text-align: right;
        }
        .auto-style11 {
            width: 271px;
        }
        .auto-style12 {
            width: 174px;
        }
        .auto-style13 {
            width: 86%;
            height: 159px;
            margin-right: 0px;
            margin-bottom: 0px;
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
        .auto-style27 {
            width: 100%;
        }
        .auto-style28 {
            width: 799px;
            text-align: right;
            height: 27px;
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
        .auto-style32 {
            width: 799px;
            text-align: right;
            height: 17px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div id="divTitle" runat="server" class="TitleContainer">
            <asp:Button ID="btnLogout" runat="server" class="btnLogoutStyle" OnClick="btnLogOut_Click" Text="Log Out" CausesValidation="False" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Label ID="lblLlechfanHostel" runat="server" Text="Llechfan Hostel" CssClass="lblTitleStyle"></asp:Label>
            <br />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblWelcome" runat="server" Text="Welcome.." class="lblStyle"></asp:Label>

        </div>
            <div id="MenuButtons" runat="server" class="MenuButtonsContainer">
                <asp:Button ID="btnAddBooking" runat="server" class="btnMenuStyle" OnClick="btnAddBooking_Click" Text="Add Booking" />
                <asp:Button ID="btnViewCurrentBookings" runat="server" class="btnMenuStyle" OnClick="btnViewCurrentBookings_Click" Text="Upcoming Bookings"/>
                <asp:Button ID="btnViewPreviousBookings" runat="server" class="btnMenuStyle" OnClick="btnViewPreviousBookings_Click" Text="Previous Bookings"/>
            </div>

                <div id="divBookings" runat="server" class="container" visible="false">
                    <div class="auto-style2">
                            <br />
                            <br />
                            <br />
                        <center>
                            <asp:GridView ID="grdCurrentBookings" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="BookingNumber" DataSourceID="SqlDataSource1" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="grdTable_SelectedIndexChanged">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="BookingNumber" HeaderText="Booking Number" ReadOnly="True" SortExpression="BookingNumber" />
                            <asp:BoundField DataField="CheckInDate" HeaderText="Check In Date" SortExpression="CheckInDate" DataFormatString="{0:d-MMM-yyyy}" />
                            <asp:BoundField DataField="CheckOutDate" DataFormatString="{0:d-MMM-yyyy}" HeaderText="Check Out Date" SortExpression="CheckOutDate" />
                            <asp:BoundField DataField="Guests" HeaderText="Guests" SortExpression="Guests" />
                            <asp:BoundField DataField="colourRoom" HeaderText="Room Colour" SortExpression="colourRoom" />
                            <asp:BoundField DataField="StandardPrice" DataFormatString="{0:c0}" HeaderText="Standard Price" HtmlEncode="False" SortExpression="Price" />
                            <asp:BoundField DataField="VolunteerPrice" DataFormatString="{0:c0}" HeaderText="Volunteer Price" HtmlEncode="False" SortExpression="VolunteerPrice" />
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Delete" OnClick="LinkButton2_Click1" OnClientClick="return confirm('Are you sure you would like to delete this? This action cannot be undone.');" Text="Delete"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" OnClick="LinkButton1_Click" Text="Edit"></asp:LinkButton>
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
                    </div>
                    <br />
                    <asp:Button ID="btnBackCurrBook" class="btnStyle" runat="server" OnClick="btnBackCurrBook_Click1" Text="Back"/>
                    <br />
                </div>

        <div runat="server" id="CreateBooking" visible="false" class="container">
        <div>
                <asp:Label ID="lblCreateBooking" runat="server" Text="Booking Details" CssClass="lblStyle"></asp:Label>
                <br />
            <hr />
        </div>
        <asp:Label ID="Label7" runat="server" class="lblSmallStyle" Text="Booking Number:"></asp:Label>
        &nbsp;<asp:TextBox ID="txtBookingNumber" runat="server" AutoCompleteType="Cellular" style="text-align: center" ReadOnly="True" OnTextChanged="txtBookingNumber_TextChanged"></asp:TextBox>
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
                    <td class="auto-style28">
                        <asp:Label ID="lblAdditionalGuests" class="lblSmallStyle" runat="server" Text="Additional Guests:"></asp:Label>
                    </td>
                    <td class="auto-style25"> 
                        <asp:DropDownList ID="drptxtGuests" runat="server" Height="18px" Width="98px">
                            <asp:ListItem>0</asp:ListItem>
                            <asp:ListItem>1</asp:ListItem>
                            <asp:ListItem>2</asp:ListItem>
                            <asp:ListItem>3</asp:ListItem>
                            <asp:ListItem>4</asp:ListItem>
                            <asp:ListItem>5</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style26">
                        </td>
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
        <asp:Button ID="btnCreateBooking" class="btnStyle" runat="server" OnClick="btnCreateBooking_Click" Text="Create" ClientIDMode="Predictable"/>
        <br />
            <asp:Button ID="btnCancelBooking" class="btnStyle" runat="server" OnClick="btnCancelBooking_Click" Text="Cancel" CausesValidation="False" />
            <br />    
        </div>


            <div id="addGuest" runat="server" class="container" visible="false">
                    <br />
                    Please fill in all booking information before adding a guest.<br />
                <hr />
                    <br />
                    <div class="auto-style2">
                        <center>
                        <asp:GridView ID="guestGrid" runat="server" AutoGenerateColumns="False" DataKeyNames="GuestID" DataSourceID="SqlDataSource2" Height="175px" Width="358px" CellPadding="4" ForeColor="#333333" GridLines="None">
                            <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="GuestID" HeaderText="GuestID" ReadOnly="True" SortExpression="GuestID" />
                            <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                            <asp:BoundField DataField="DOB" HeaderText="DOB" SortExpression="DOB" />
                            <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                            <asp:BoundField DataField="BookingNum" HeaderText="BookingNum" SortExpression="BookingNum" />
                            <asp:BoundField DataField="MemberID" HeaderText="MemberID" SortExpression="MemberID" />

                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" OnClientClick="return confirm('Are you sure you would like to delete this? This action cannot be undone.');" CommandName="Delete" Text="Delete" OnClick="LinkButton3_Click"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" OnClick="LinkButton2_Click" Text="Edit"></asp:LinkButton>
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
                    </div>

                <table class="auto-style4" align="center">
                    <tr>
                        <td class="auto-style9">
                            <asp:Label ID="Label18" runat="server" Text="Guest ID:"></asp:Label>
                        </td>
                        <td class="auto-style11">
                            <asp:TextBox ID="txtGuestID" runat="server" AutoCompleteType="Cellular" ReadOnly="True" style="text-align: center"></asp:TextBox>
                        </td>
                        <td class="auto-style12">&nbsp;</td>
                    </tr>
                    <tr>
                        <td class="auto-style9">
                            <asp:Label ID="Label14" runat="server" Text="Guest Name:"></asp:Label>
                        </td>
                        <td class="auto-style11">
                            <asp:TextBox ID="txtGuestName" runat="server" AutoCompleteType="Cellular" style="text-align: center"></asp:TextBox>
                        </td>
                        <td class="auto-style12">
                            <asp:RequiredFieldValidator ID="rfvGuestName" runat="server" ControlToValidate="txtGuestName" ErrorMessage="Guest Name is Needed" ForeColor="Red">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style9">
                            <asp:Label ID="Label15" runat="server" Text="Guest Date Of Birth"></asp:Label>
                        </td>
                        <td class="auto-style11">
                            <BDP:BasicDatePicker ID="txtGuestDOB" runat="server" DateFormat="dd-MM-yyyy" SelectedDate="" OnSelectionChanged="dateCheckOut_SelectionChanged" />
                        </td>
                        <td class="auto-style12">
                            <asp:RequiredFieldValidator ID="rfvGuestDOB" runat="server" ControlToValidate="txtGuestDOB" ErrorMessage="RequiredFieldValidator" ForeColor="Red">*</asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="rvGuestDOB" runat="server" ControlToValidate="txtGuestDOB" ErrorMessage="*Must Be 14+" ForeColor="Red" MinimumValue="01/01/1900" Type="Date"></asp:RangeValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style9">
                            <asp:Label ID="Label16" runat="server" Text="Guest Gender"></asp:Label>
                        </td>
                        <td class="auto-style11">
                            <asp:DropDownList ID="drptxtGuestGender" runat="server" Height="28px" Width="122px">
                                <asp:ListItem>Select Gender</asp:ListItem>
                                <asp:ListItem>Male</asp:ListItem>
                                <asp:ListItem>Female</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style12">
                            <asp:RequiredFieldValidator ID="rfvGuestGender" runat="server" ControlToValidate="drptxtGuestGender" ErrorMessage="Guest Gender is Needed" ForeColor="Red" InitialValue="Select Gender">*</asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
                <hr />
                <asp:Button ID="btnAddGuest" class="btnStyle" runat="server" OnClick="btnAddGuest_Click" Text="Add" CausesValidation="False" />
                &nbsp;<br />
                <asp:Button ID="btnCancelGuest" class="btnStyle" runat="server" OnClick="btnCancelGuest_Click" Text="Cancel" CausesValidation="False" />
            </div>  

            <footer>   
            </footer> 
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" OnSelecting="SqlDataSource1_Selecting" SelectCommand="SELECT * FROM [bookings] WHERE [MemberID] = @id AND CheckInDate > GETDATE()"  DeleteCommand="DELETE FROM bookings
WHERE BookingNumber = @BookingNumber
">
                    <DeleteParameters>
                        <asp:Parameter Name="BookingNumber" />
                    </DeleteParameters>
                    <SelectParameters>
        <asp:SessionParameter Name="id" SessionField="id" />

    </SelectParameters>

                    </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"  SelectCommand="SELECT * FROM [guests] WHERE ([BookingNum] = @BookingNum)" DeleteCommand="DELETE FROM guests
WHERE GuestID = @GuestID
">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtBookingNumber" Name="BookingNum" PropertyName="Text" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

                
    </form>
</body>

</html>    
