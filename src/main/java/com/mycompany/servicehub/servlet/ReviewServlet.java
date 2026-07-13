package com.mycompany.servicehub.servlet;

import com.mycompany.servicehub.dao.ReviewDAO;
import com.mycompany.servicehub.model.Review;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {
    private ReviewDAO reviewDAO = new ReviewDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            Review r = new Review();
            r.setBookingId(Integer.parseInt(request.getParameter("bookingId")));
            r.setReviewedUserId(Integer.parseInt(request.getParameter("reviewedUserId")));
            r.setReviewerId(Integer.parseInt(request.getParameter("reviewerId")));
            r.setComment(request.getParameter("comment"));
            r.setRating(Integer.parseInt(request.getParameter("rating")));

            if (reviewDAO.addReview(r)) {
                response.sendRedirect("customer/my-bookings.jsp?status=reviewed");
            } else {
                response.sendRedirect("reviews.jsp?error=DatabaseError");
            }
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            reviewDAO.deleteReview(id);
            response.sendRedirect("admin/reviews.jsp");
        }
    }
}