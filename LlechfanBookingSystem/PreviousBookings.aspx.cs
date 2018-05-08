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
    public partial class PreviousBookings : System.Web.UI.Page
    {
        //creating the connection to the database
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            //welcoming the user by name using a session
            if (Session["New"] != null)
            {
                lblWelcome.Text = "" + Session["New"].ToString();
            }
            else
            {
                Response.Redirect("~/NewLogin.aspx");
            }
        }

        protected void PBreturnToMenu_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Members/HomePage.aspx");
        }

        protected void grdTable_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void sqlDataPreviousBookings_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
        }

        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            //logout of the session
            Session["New"] = null;
            Session["id"] = null;
            Response.Redirect("~/NewLogin.aspx");
        }
    }
}