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
    public partial class AdminAllUsers : System.Web.UI.Page
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

        protected void AUAreturnToMenu_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Members/Admin.aspx");
        }

        protected void btnLogOut_Click(object sender, EventArgs e)
        {
            //logout of the session
            Session["New"] = null;
            Session["id"] = null;
            Response.Redirect("~/NewLogin.aspx");
        }

        protected void btnDeleteActiveUser_Click(object sender, EventArgs e)
        {

        }
    }
}