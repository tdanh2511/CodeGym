package com.example.dictionaryservlet;

import java.io.*;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "DictionarySimple", value = "/dictionary")
public class DictionaryBasic extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html; charset=UTF-8");
        resp.setCharacterEncoding("UTF-8");

        HashMap<String, String> listWord = new HashMap<>();
        listWord.put("hippo", "Hà mã");
        listWord.put("dog", "Con chó");
        listWord.put("cat", "Con mèo");
        listWord.put("monkey", "Con khỉ");
        listWord.put("duck", "Con vịt");
        listWord.put("bird", "Con chim");
        listWord.put("shark", "Cá mập");
        listWord.put("crocodile", "Cá sấu");
        listWord.put("pig", "Con lợn");
        listWord.put("sheep", "Con cừu");
        String search = req.getParameter("txtSearch").toLowerCase().trim();

        PrintWriter out = resp.getWriter();
        out.println("<html><body>");

        if (search != null) {
            String result = listWord.get(search.toLowerCase().trim());
            if (result != null) {
                out.println("<h3>Word: " + search + "</h3>");
                out.println("<h3>Result: " + result + "</h3>");
            } else {
                out.println("<h3>Not found</h3>");
            }
        }

        out.println("</body></html>");
    }
}