using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Collections;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Security.Cryptography;

namespace LlechfanBookingSystem
{
    public partial class Register : System.Web.UI.Page
    {
        //creating the connection to the database
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            //open the connection to the database when the page loads
            con.Open();

            //upon loading the page, the date will be set back 14 years from now
            dateCheckIn.SelectedValue = DateTime.Today.AddYears(-14);
            rvDOB.MaximumValue = DateTime.Today.AddYears(-14).ToShortDateString();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            //variables of date of birth
            var customerDOB = dateCheckIn.SelectedDate;
            var userDOB = customerDOB.Date;

            //make sure the membership ID doesnt already exist
            string checkuser = "select count(*) from users where MembershipID='" + txtMembershipID.Text + "'";
            SqlCommand com = new SqlCommand(checkuser, con);
            int temp = Convert.ToInt32(com.ExecuteScalar().ToString());

            //if the membershipID already exists, perfrom error message
            if (temp == 1)
            {
                lblMemberIDem.Visible = true;
                lblMemberIDem.Text = "*Membership ID is already being used.";

            } else {

                //perfrom function of hashing password before saving it to the database
                string hashPassword = Encrypt(txtPassword.Text);

                //inputting the data into the user table, while closing the database
                SqlCommand insert = new SqlCommand("Insert into users(MembershipID, Title, Firstname, Surname, EmailAddress,  DOB, Gender, Password, PhoneNumber, Role) values('"
                + txtMembershipID.Text + "','" + drptxtTitle.Text + "','" + txtFirstname.Text + "','" + txtSurname.Text + "','" + txtEmailAddress.Text + "','"
                + userDOB.ToString("MM/dd/yyyy") + "','" + drptxtGender.Text + "','" + hashPassword.ToString() + "','" + txtPhoneNumber.Text + "', 'volunteer')", con);
                insert.ExecuteNonQuery();
                con.Close();

                //notify the user their details have been saved and clear the text
                lblMemberIDem.Visible = false;
                txtMembershipID.Text = "";
                drptxtTitle.Text = "";
                txtFirstname.Text = "";
                txtSurname.Text = "";
                txtEmailAddress.Text = "";
                dateCheckIn.SelectedDate = DateTime.Today;
                drptxtGender.Text = "";
                txtPhoneNumber.Text = "";
                txtPassword.Text = "";

                //pop up noting the account has been saved
                ClientScript.RegisterStartupScript(this.GetType(), "Confirmation", "alert('You have successfully registered your account.'); window.location='NewLogin.aspx';", true);
            }
        }

        protected void btnLoginScreen_Click(object sender, EventArgs e)
        {
            //redirect to login screen
            Response.Redirect("NewLogin.aspx");
        }

        protected string Encrypt(string password)
        {
            //hashing of the password using the UTF8Encoding
            using (MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider())
            {
                UTF8Encoding utf8 = new UTF8Encoding();
                byte[] encryptedPassword = md5.ComputeHash(utf8.GetBytes(password));
                return Convert.ToBase64String(encryptedPassword);
            }
        }

        protected void BasicDatePicker1_SelectionChanged(object sender, EventArgs e)
        {
        }
    }
}