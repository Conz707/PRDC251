using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace LlechfanBookingSystem.Members
{
    public partial class Admin : System.Web.UI.Page
    {
        //creating the connection to the database
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            validateCheckIn.MinimumValue = DateTime.Today.ToShortDateString();

            //open the connection to the database when the page loads
            con.Open();

            //welcoming the user by name using a session
            if (Session["New"] != null)
            {
                lblWelcome.Text = "Welcome " + Session["New"].ToString();
            }

            //otherwise they get redirected to the create login
            else
                Response.Redirect("~/NewLogin.aspx");
        }

        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            //logout of the session
            Session["New"] = null;
            Session["id"] = null;
            Response.Redirect("~/NewLogin.aspx");
        }

        public void calculatePrice()
        {
            var daysStayed = (dateCheckOut.SelectedDate - dateCheckIn.SelectedDate).TotalDays;
            int standardPrice = Convert.ToInt32(daysStayed) * 10;
            int volunteerPrice = Convert.ToInt32(daysStayed) * 3;
            txtBookingPrice.Text = "£" + Convert.ToString(standardPrice);
            txtVolunteerBookingPrice.Text = "£" + Convert.ToString(volunteerPrice);
        }

        protected void dateCheckOut_SelectionChanged(object sender, EventArgs e)
        {
            calculatePrice();
        }


        protected void btnAllActiveAccounts_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/AdminAllUsers.aspx");
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
        }

        protected void Calendar2_SelectionChanged(object sender, EventArgs e)
        {
        }

        protected void BasicDatePicker1_SelectionChanged(object sender, EventArgs e)
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
        protected void drptxtGuests_SelectedIndexChanged(object sender, EventArgs e)
        {
        }
        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
        }
        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
        }
        protected void txtMembershipID_TextChanged(object sender, EventArgs e)
        {
        }
        protected void grdTable_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        protected void SQLDSAdminAllBookings_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void btnDeleteActiveBooking_Click(object sender, EventArgs e)
        {

        }

        protected void btnBackActiveBookings_Click(object sender, EventArgs e)
        {
            divAllBookings.Visible = false;
            divAdminMenu.Visible = true;
        }

        protected void btnAllBookings_Click(object sender, EventArgs e)
        {
            divAllBookings.Visible = true;
            divAdminMenu.Visible = false;
        }

        protected void btnCurrentVisitors_Click(object sender, EventArgs e)
        {
            divCurrentBookings.Visible = true;
            divAdminMenu.Visible = false;
        }

        protected void btnBackCurrentBookings_Click(object sender, EventArgs e)
        {
            divAdminMenu.Visible = true;
            divCurrentBookings.Visible = false;
        }

        protected void btnActiveBookingsEdit_Click(object sender, EventArgs e)
        {
            divEditBooking.Visible = true;

            LinkButton editButton = sender as LinkButton;
            GridViewRow gvRow = editButton.NamingContainer as GridViewRow;
            int index = gvRow.RowIndex;

            //display booking to be edited
            txtBookingNumber.Text = gvRow.Cells[0].Text;
            txtMembershipID.Text = gvRow.Cells[1].Text;
            dateCheckIn.SelectedDate = Convert.ToDateTime(gvRow.Cells[2].Text);
            dateCheckOut.SelectedDate = Convert.ToDateTime(gvRow.Cells[3].Text);
            drptxtGuests.Text = gvRow.Cells[4].Text;
            drptxtRoomColour.Text = gvRow.Cells[5].Text;
            txtBookingPrice.Text = gvRow.Cells[6].Text;
            txtVolunteerBookingPrice.Text = gvRow.Cells[7].Text;
        }

        protected void btnSaveEditing_Click(object sender, EventArgs e)
        {
            var dateTimeCheckIn = dateCheckIn.SelectedDate;
            var dateTimeCheckOut = dateCheckOut.SelectedDate;
            var checkIn = dateTimeCheckIn.Date;
            var checkOut = dateTimeCheckOut.Date;
            int bookingPrice = Convert.ToInt32(txtBookingPrice.Text.Replace("£", ""));
            int volunteerPrice = Convert.ToInt32(txtVolunteerBookingPrice.Text.Replace("£", ""));

            string memberGenderQuery = "SELECT Gender FROM users where MembershipID = '" + Session["id"] + "'";

            /*
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
            */

            //sqlcommand that saves the new details over the previous ones
            SqlCommand update = new SqlCommand("Update bookings set Guests = '" + drptxtGuests.Text + "'," + "CheckInDate = '" + checkIn.ToString("MM/dd/yyyy")
                + "'," + "CheckOutDate = '" + checkOut.ToString("MM/dd/yyyy") + "'," + "colourRoom = '" + drptxtRoomColour.Text
                + "'," + "StandardPrice = '" + bookingPrice + "'," + "VolunteerPrice = '" + volunteerPrice + "'," + "MemberID = '" + txtMembershipID.Text + 
                "' where BookingNumber = '" + txtBookingNumber.Text + "'", con);
            update.ExecuteNonQuery();
            con.Close();

            Response.Write("<script>alert('Your chnages have been saved. You will now be redirected.') </script>");
            //notify the user their edited details has been saved
            grdAdminAllBookings.DataBind();
            txtBookingNumber.Text = "";
            txtMembershipID.Text = "";
            dateCheckIn.SelectedDate = DateTime.Today;
            dateCheckOut.SelectedValue = DateTime.Today.AddDays(1);
            drptxtGuests.Text = "";
            drptxtRoomColour.Text = "";
            txtBookingPrice.Text = "";
            txtVolunteerBookingPrice.Text = "";

            divEditBooking.Visible = false;
        }

        protected void btnCancelEditing_Click(object sender, EventArgs e)
        {
            //clear text boxes
            txtBookingNumber.Text = "";
            dateCheckIn.SelectedDate = DateTime.Today;
            dateCheckOut.SelectedValue = DateTime.Today.AddDays(1);
            drptxtGuests.Text = "";
            drptxtRoomColour.Text = "";
            txtBookingPrice.Text = "";
            txtVolunteerBookingPrice.Text = "";

            divEditBooking.Visible = false;
        }
    }
}