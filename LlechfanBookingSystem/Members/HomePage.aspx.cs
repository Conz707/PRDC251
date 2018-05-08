using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;


namespace LlechfanBookingSystem
{
    public partial class HomePage : System.Web.UI.Page
    {
        //creating the connection to the database
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        { 
            //open the connection 
            con.Open();
            rvGuestDOB.MaximumValue = DateTime.Today.AddYears(-14).ToShortDateString();
            txtGuestDOB.SelectedDate = DateTime.Today.AddYears(-14);
            validateCheckIn.MinimumValue = DateTime.Today.ToShortDateString();

            //welcoming the user by name using a session
            if (Session["New"] != null)
            {
                lblWelcome.Text = "Welcome " + Session["New"].ToString();

            } else {

                Response.Redirect("~/NewLogin.aspx");
            }
        }

        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            //logout of the session
            Session["New"] = null;
            Session["id"] = null;
            Response.Redirect("~/NewLogin.aspx");
        }

        protected void btnCreateBooking_Click(object sender, EventArgs e)
        {
            //half working code
            int totalCapacity;
            string room;
            string memberGenderQuery = "SELECT Gender FROM users where MembershipID = '" + Session["id"] + "'";
            SqlCommand memberGenderCom = new SqlCommand(memberGenderQuery, con);
            string memberGender = Convert.ToString(memberGenderCom.ExecuteNonQuery());

            //sets room colour and total capacity of room to that rooms capacity for easier use of information into sql commands etc
            if (memberGender == "Male" || drptxtGuests.Text == "5" || drptxtGuests.Text == "4")
            {
                room = "Yellow";

                totalCapacity = 6;
            }
            else if (drptxtGuests.Text == "1")
            {
                room = "Green";

                totalCapacity = 2;
            }
            else
            {
                room = "Blue";
                totalCapacity = 4;
            }

            var dateTimeCheckIn = dateCheckIn.SelectedDate;
            var checkIn = dateTimeCheckIn.Date;
            var dateTimeCheckOut = dateCheckIn.SelectedDate;
            var checkOut = dateTimeCheckIn.Date;

            string dateRoomCapacityQuery = "SELECT ISNULL(sum(Guests), 0) FROM bookings where checkInDate ='" + checkIn.ToString("MM/dd/yyyy") + "' and colourRoom ='" + room + "'";
            string dateRoomCapacityQuery2 = "SELECT ISNULL(sum(Guests), 0) FROM bookings where checkOutDate ='" + checkOut.ToString("MM/dd/yyyy") + "' and colourRoom ='" + room + "'";
            string dateRoomCapacityQuery3 = "SELECT ISNULL(sum(Guests), 0) FROM bookings where checkInDate between '" + checkOut.ToString("MM/dd/yyyy") + "' and '" + checkIn.ToString("MM/dd/yyyy") + "' and colourRoom ='" + room + "'";

            SqlCommand dateRoomCapacityCom = new SqlCommand(dateRoomCapacityQuery, con);
            SqlCommand dateRoomCapacityCom2 = new SqlCommand(dateRoomCapacityQuery2, con);
            SqlCommand dateRoomCapacityCom3 = new SqlCommand(dateRoomCapacityQuery3, con);

            string numOfBookingsQuery = "SELECT ISNULL(count(Guests), 0) FROM bookings where checkInDate ='" + checkIn.ToString("MM/dd/yyyy") + "' and colourRoom ='" + room + "'"; //used to add 1 to bookingDate capacity count for the person who booked excluding guests
            SqlCommand numOfBookingsQueryCom = new SqlCommand(numOfBookingsQuery, con);

            totalCapacity = (totalCapacity - ((Convert.ToInt32(dateRoomCapacityCom3.ExecuteScalar()) + Convert.ToInt32(dateRoomCapacityCom2.ExecuteScalar()) + (Convert.ToInt32(numOfBookingsQueryCom.ExecuteScalar()) + Convert.ToInt32(drptxtGuests.Text)))));     //deduct from room capacity guests on same checkInDate, intended # of guests on booking date, and -1 for the booker.

            if (totalCapacity <= 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "Capacity", "Booking Unavailable('No room left.');", true);
            }
            else
            {
                createOrEditFunction();
                calculatePrice();
                Response.Write("<script>alert('Booking has been placed, you will recieve an email conformation. You will now be redirected') </script>");
                CreateBooking.Visible = false;
                divBookings.Visible = true;
                lblLlechfanHostel.Text = "Upcoming Bookings";
                lblWelcome.Text = "" + Session["New"].ToString();
            }
            //end of half working code
        }

        protected void btnAddBooking_Click(object sender, EventArgs e)
        {
            //change the title text
            lblLlechfanHostel.Text = "Make A Booking";
            lblWelcome.Text = "" + Session["New"].ToString();

            //set calendars to appropriate dates
            string autoBookingQuery = "SELECT ISNULL(MAX(BookingNumber), 0) FROM bookings";
            SqlCommand autoBookingCom = new SqlCommand(autoBookingQuery, con);
            int autoBooking = Convert.ToInt32(autoBookingCom.ExecuteScalar()) + 1;
            txtBookingNumber.Text = Convert.ToString(autoBooking);

            grdCurrentBookings.DataBind();
            dateCheckIn.SelectedDate = DateTime.Today;
            dateCheckOut.SelectedValue = DateTime.Today.AddDays(1);
            txtBookingPrice.Text = "£10";
            txtVolunteerBookingPrice.Text = "£3";
            CreateBooking.Visible = true;
            MenuButtons.Visible = false;
        }

        protected void btnCancelBooking_Click(object sender, EventArgs e)
        {
            //change the title text
            lblLlechfanHostel.Text = "Llechfan Hostel";
            lblWelcome.Text = "Welcome " + Session["New"].ToString();

            //reset booking
            txtBookingNumber.Text = "";
            dateCheckIn.SelectedDate = DateTime.Today;
            dateCheckOut.SelectedValue = DateTime.Today.AddDays(1);
            drptxtGuests.Text = "1";
            txtBookingPrice.Text = "";
            CreateBooking.Visible = false;
            MenuButtons.Visible = true;
            lblCreateBooking.Text = "Create a Booking";
            btnCreateBooking.Text = "Create Booking";
        }

        protected void LinkButton2_Click(object sender, EventArgs e)
        {
            btnAddGuest.Text = "Confirm Changes";

            //borrowed code
            LinkButton editButton = sender as LinkButton;
            GridViewRow gvRow = editButton.NamingContainer as GridViewRow;
            int index = gvRow.RowIndex;

            //display booking to be edited
            txtGuestID.Text = gvRow.Cells[0].Text;
            txtGuestName.Text = gvRow.Cells[1].Text;
            txtGuestDOB.SelectedDate = Convert.ToDateTime(gvRow.Cells[2]);
            drptxtGuestGender.Text = gvRow.Cells[3].Text;
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            //selecting edit booking option 
            CreateBooking.Visible = true;
            divBookings.Visible = false;
            lblCreateBooking.Text = "Edit a Booking";
            btnCreateBooking.Text = "Confirm Changes";

            //borrowed code
            LinkButton editButton = sender as LinkButton;
            GridViewRow gvRow = editButton.NamingContainer as GridViewRow;
            int index = gvRow.RowIndex;
            gvRow.Attributes.Add("onmouseover", "this.originalstyle=this.style.backgroundColor;this.style.backgroundColor='#EEFFAA'");
            gvRow.Attributes.Add("onmouseout", "this.style.backgroundColor=this.originalstyle;");

            //display booking to be edited
            txtBookingNumber.Text = gvRow.Cells[0].Text;
            dateCheckIn.SelectedDate = Convert.ToDateTime(gvRow.Cells[1].Text);
            dateCheckOut.SelectedDate = Convert.ToDateTime(gvRow.Cells[2].Text);
            drptxtGuests.Text = gvRow.Cells[3].Text;
            txtBookingPrice.Text = gvRow.Cells[5].Text;
            txtVolunteerBookingPrice.Text = gvRow.Cells[6].Text;
        }

        protected void BasicDatePicker1_SelectionChanged(object sender, EventArgs e)
        {
            calculatePrice();
        }

        protected void dateCheckOut_SelectionChanged(object sender, EventArgs e)
        {
            calculatePrice();
        }

        public void calculatePrice()
        {
            var daysStayed = (dateCheckOut.SelectedDate - dateCheckIn.SelectedDate).TotalDays;
            int standardPrice = Convert.ToInt32(daysStayed) * 10;
            int volunteerPrice = Convert.ToInt32(daysStayed) * 3;
            txtBookingPrice.Text = "£" + Convert.ToString(standardPrice);
            txtVolunteerBookingPrice.Text = "£" + Convert.ToString(volunteerPrice);
        }

        protected void btnAddMemberGuest_Click(object sender, EventArgs e)
        {
            addGuest.Visible = true;        
        }

        protected void btnAddGuest_Click(object sender, EventArgs e)            //half working function, minimise
        {
            var dateDOB = txtGuestDOB.SelectedDate;
            var guestDOB = dateDOB.Date;

            //Increment the GuestID number by 1 with every new guest
            string autoGuestIDQuery = "SELECT ISNULL(MAX(GuestID),0) FROM guests";
            SqlCommand autoGuestIDCom = new SqlCommand(autoGuestIDQuery, con);
            int autoGuestID = Convert.ToInt32(autoGuestIDCom.ExecuteScalar()) + 1;

            string addOrEdit = btnAddGuest.Text;
            txtGuestID.Text = Convert.ToString(autoGuestID);

            if (addOrEdit.Contains("Confirm Changes"))
            {
                //sqlcommand that saves the new details over the previous ones
                SqlCommand update = new SqlCommand("Update guests set Name = '" + txtGuestName.Text + "'," + "DOB = '" + guestDOB.ToString("MM/dd/yyyy") + "'," + "Gender = '" + drptxtGuestGender.Text + "' where GuestID = '" + txtGuestID.Text + "'", con);
                update.ExecuteNonQuery();
                con.Close();

                Response.Write("<script>alert('Your chnages have been saved. You will now be redirected.') </script>");
                //notify the user their edited details has been saved
                guestGrid.DataBind();
                txtGuestID.Text = "";
                txtGuestName.Text = "";
                txtGuestDOB.SelectedDate = DateTime.Today.AddYears(-14);
                drptxtGuestGender.Text = "";
                btnAddGuest.Text = "Add";
                CreateBooking.Visible = false;

            } else {

                    createOrEditFunction();
                    con.Open();
                    //inputting the data into the bookings table, then closing the database
                    SqlCommand addingGuest = new SqlCommand("Insert into guests(GuestID, Name, DOB, Gender, BookingNum, MemberID) values('"
                    + autoGuestID + "','" + txtGuestName.Text + "','" + guestDOB.ToString("MM/dd/yyyy") + "','" + drptxtGuestGender.Text + "','" + txtBookingNumber.Text + "','" + Session["id"] + "')", con);
                    addingGuest.ExecuteNonQuery();
                    con.Close();

                //clear the details of the guest once theyve been addedd
                guestGrid.DataBind();
                txtGuestID.Text = "";
                txtGuestName.Text = "";
                txtGuestDOB.SelectedDate = DateTime.Today.AddYears(-14);
                drptxtGuestGender.Text = "";
                }
                calculateNumberGuests();    
        }
    
        protected void btnCancelGuest_Click(object sender, EventArgs e)
        {
            //clear the details of the guest once theyve been addedd
            txtGuestID.Text = "";
            txtGuestName.Text = "";
            txtGuestDOB.SelectedDate = DateTime.Today.AddYears(-14);
            drptxtGuestGender.Text = "";
            addGuest.Visible = false;
        }

        protected void createOrEditFunction()
        {
            //Increment the max booking number by 1 with every new booking
            string autoBookingQuery = "SELECT ISNULL(MAX(BookingNumber), 0) FROM bookings";
            SqlCommand autoBookingCom = new SqlCommand(autoBookingQuery, con);
            int autoBooking = Convert.ToInt32(autoBookingCom.ExecuteScalar()) + 1;

            //inputting the data into the bookings table, then closing the database
            var dateTimeCheckIn = dateCheckIn.SelectedDate;
            var dateTimeCheckOut = dateCheckOut.SelectedDate;
            var checkIn = dateTimeCheckIn.Date;
            var checkOut = dateTimeCheckOut.Date;
            int bookingPrice = Convert.ToInt32(txtBookingPrice.Text.Replace("£", ""));
            int volunteerPrice = Convert.ToInt32(txtVolunteerBookingPrice.Text.Replace("£", ""));
            string createOrEdit = lblCreateBooking.Text;

            string memberGenderQuery = "SELECT Gender FROM users where MembershipID = '" + Session["id"] + "'";
            SqlCommand memberGenderCom = new SqlCommand(memberGenderQuery, con);
            string memberGender = Convert.ToString(memberGenderCom.ExecuteNonQuery());

            string room;

            if (memberGender == "Male" || drptxtGuests.Text == "5")
                room = "Yellow";
            else if (drptxtGuests.Text == "1")
            {
                room = "Green";
            }
            else
            {
                room = "Blue";
            }

            if (createOrEdit.Contains("Edit"))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "BookingEdited", "Booking Edited('Your booking has been edited.');", true);
                //sqlcommand that saves the new details over the previous ones
                SqlCommand update = new SqlCommand("Update bookings set Guests = '" + drptxtGuests.Text + "'," + "CheckInDate = '" + checkIn.ToString("MM/dd/yyyy")
                    + "'," + "CheckOutDate = '" + checkOut.ToString("MM/dd/yyyy") + "'," + "colourRoom = '" + room
                    + "'," + "StandardPrice = '" + bookingPrice + "'," + "VolunteerPrice = '" + volunteerPrice + "' where BookingNumber = '" 
                    + txtBookingNumber.Text + "'", con);
                update.ExecuteNonQuery();
                con.Close();

                Response.Write("<script>alert('Your chnages have been saved. You will now be redirected.') </script>");
                //notify the user their edited details has been saved
                grdCurrentBookings.DataBind();
                txtBookingNumber.Text = Convert.ToString(autoBooking);
                dateCheckIn.SelectedDate = DateTime.Today;
                dateCheckOut.SelectedValue = DateTime.Today.AddDays(1);
                txtBookingPrice.Text = "";
                txtVolunteerBookingPrice.Text = "";
                CreateBooking.Visible = false;

            } else {

                ClientScript.RegisterStartupScript(this.GetType(), "BookingCreated", "Booking Created('Your booking has been created.');", true);
                //inputting the data into the bookings table, then closing the database
                SqlCommand insert = new SqlCommand("Insert into bookings(BookingNumber, MemberID, CheckInDate, CheckOutDate, Guests, colourRoom, StandardPrice, VolunteerPrice) values('"
                        + autoBooking + "','" + Session["id"] + "','" + checkIn.ToString("MM/dd/yyyy") + "','" + checkOut.ToString("MM/dd/yyyy") + "','"
                        + drptxtGuests.Text + "','" + room + "','" + bookingPrice + "','" + volunteerPrice + "')", con);
                    insert.ExecuteNonQuery();
                    con.Close();

                //notify the user their booking has been saved, followed by resetting the textboxes
                    grdCurrentBookings.DataBind();
                    txtBookingNumber.Text = Convert.ToString(autoBooking);
                    dateCheckIn.SelectedDate = DateTime.Today;
                    dateCheckOut.SelectedValue = DateTime.Today.AddDays(1);
                    txtBookingPrice.Text = "";
            }
        }

        private void calculateNumberGuests()
        {
            con.Open();
            string numberOfGuestsQuery = "SELECT ISNULL(count(*), 0) FROM guests WHERE BookingNum = '" + txtBookingNumber.Text + "'";
            SqlCommand numberOfGuestsCom = new SqlCommand(numberOfGuestsQuery, con);
            int numberOfGuests = Convert.ToInt32(numberOfGuestsCom.ExecuteScalar());
            drptxtGuests.Text = Convert.ToString(numberOfGuests);
            con.Close();
        }

        protected void btnBackCurrBook_Click1(object sender, EventArgs e)
        {
            divBookings.Visible = false;
            MenuButtons.Visible = true;
            lblLlechfanHostel.Text = "Llechfan Hostel";
        }

        protected void btnViewCurrentBookings_Click(object sender, EventArgs e)
        {
            divBookings.Visible = true;
            MenuButtons.Visible = false;
            lblLlechfanHostel.Text = "Upcoming Bookings";
            lblWelcome.Text = "" + Session["New"].ToString();
        }

        protected void btnViewPreviousBookings_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/PreviousBookings.aspx");
        }

        protected void drptxtGuests_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void LinkButton3_Click(object sender, EventArgs e)
        {

        }

        protected void LinkButton2_Click1(object sender, EventArgs e)
        {

        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void SqlDataSource2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
        }

        protected void txtMembershipID_TextChanged(object sender, EventArgs e)
        {
        }

        protected void grdTable_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
        }

        protected void Calendar2_SelectionChanged(object sender, EventArgs e)
        {
        }

        protected void txtBookingPrice_TextChanged(object sender, EventArgs e)
        {
        }

        protected void txtBookingNumber_TextChanged(object sender, EventArgs e)
        {
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
        }

        protected void sqlDataPreviousBookings_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
}