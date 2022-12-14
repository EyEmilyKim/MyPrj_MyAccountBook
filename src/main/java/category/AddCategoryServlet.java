package category;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Category;
import utility.CategoryDAO;

/**
 * Servlet implementation class AddCategoryServlet
 */
@WebServlet("/addCategory.do")
public class AddCategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCategoryServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("USER_ID");
		request.setCharacterEncoding("UTF-8");
		String Sseqno = request.getParameter("SEQNO");
		int seqno = Integer.parseInt(Sseqno);
		String inex = request.getParameter("INEX");
		String cate_name = request.getParameter("CNAME");
		String cate_code = inex + Sseqno;
		Category c = new Category();
		c.setSeqno(seqno);
		c.setInex(inex);
		c.setCate_name(cate_name);
		c.setCate_code(cate_code);
		c.setId(id);
		CategoryDAO dao = new CategoryDAO();
		boolean flag = dao.insertCategory(c); 
		String url = "addCategoryResult.jsp?R=";
		if(flag) {
			response.sendRedirect(url + "Y");
		}else {
			response.sendRedirect(url + "N");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
