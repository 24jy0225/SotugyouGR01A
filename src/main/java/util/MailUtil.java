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
	private static final String FROM = "24jy0225@jynet.jec.ac.jp";
	private static final String HOST = "10.64.144.9";

	// --- ① 会員登録用 ---
	public static void sendWelcomeMail(String to, String authURL) {
		String subject = "【The Shisha Honjin】会員登録のご確認";
		String body = """
				━━━━━━━━━━━━━━━━━━━━━━━━━━━━
				　The Shisha HONJIN　会員登録のご確認
				━━━━━━━━━━━━━━━━━━━━━━━━━━━━

				このたびは、The Shisha Honjin にご登録いただき、
				誠にありがとうございます。

				会員登録を完了するために、以下のURLにアクセスして
				メールアドレスの認証をお願いいたします。

				─────────────────────────
				■ 認証URL
				%s
				─────────────────────────

				URLをクリックすることで、会員登録が完了いたします。

				【ご注意】
				・このメールに心当たりのない場合は、破棄してください
				・認証URLの有効期限は送信後 24時間 です
				・有効期限が切れた場合は、再度登録手続きをお願いします
				・本メールは送信専用のため、返信はできません
				""".formatted(authURL);

		executeSend(to, subject, body);
	}

	// --- ② パスワード再設定用 ---
	public static void sendPasswordResetMail(String to, String resetURL) {
		String subject = "【The Shisha Honjin】パスワード再設定のご案内";
		String body = """
				━━━━━━━━━━━━━━━━━━━━━━━━━━━━
				　The Shisha HONJIN　パスワード再設定のご案内
				━━━━━━━━━━━━━━━━━━━━━━━━━━━━

				パスワード再設定のリクエストを受け付けました。

				以下のURLにアクセスして、新しいパスワードを設定してください。

				─────────────────────────
				■ パスワード再設定URL
				%s
				─────────────────────────

				【ご注意】
				・このメールに心当たりのない場合は、破棄してください
				　（パスワードは変更されません）
				・再設定URLの有効期限は送信後 24時間 です
				・有効期限が切れた場合は、再度お手続きをお願いします
				・本メールは送信専用のため、返信はできません
				""".formatted(resetURL);

		executeSend(to, subject, body);
	}

	// --- 共通の送信処理（private） ---
	private static void executeSend(String to, String subject, String content) {
		Properties props = new Properties();
		props.put("mail.smtp.host", HOST);
		Session session = Session.getInstance(props, null);

		try {
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(FROM));
			msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to));
			msg.setSubject(subject);
			msg.setSentDate(new Date());

			// 共通のフッターを結合
			String footer = """

					ご不明な点がございましたら、お気軽にお問い合わせください。

					───────────────────────────
					The Shisha Honjin
					お問い合わせ：03-1234-5678
					©The Shisha Honjin
					───────────────────────────
					""";
			String fullBody = (content + footer).replace("\n", "\r\n");
			msg.setText(fullBody);
			Transport.send(msg);
			System.out.println("送信完了: " + subject);

		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}