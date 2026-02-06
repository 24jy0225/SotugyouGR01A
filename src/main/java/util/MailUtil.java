package util;

import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MailUtil {
    // 先生に指定された情報を入れる
    private static final String FROM = "24jy0225@jynet.jec.ac.jp"; 
    private static final String HOST = "10.64.144.9"; 

    public static void send(String to, String authURL) {
        Properties props = new Properties();
        props.put("mail.smtp.host", HOST);

        // 教室内サーバ用（認証なし）
        Session session = Session.getInstance(props, null);

        try {
            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(FROM));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
            
            msg.setSubject("【席予約システム】会員登録を完了させてください");
            msg.setSentDate(new Date());

            String body = "会員登録ありがとうございます。\n"
                        + "以下のリンクをクリックして、登録を完了させてください。\n\n"
                        + authURL;
            msg.setText(body);

            Transport.send(msg);
            System.out.println("送信完了");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}