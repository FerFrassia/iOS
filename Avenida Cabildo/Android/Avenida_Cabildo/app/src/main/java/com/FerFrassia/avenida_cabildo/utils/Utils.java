package com.FerFrassia.avenida_cabildo.utils;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map.Entry;
import java.util.NavigableMap;
import java.util.TreeMap;

import javax.net.ssl.HttpsURLConnection;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.Signature;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.graphics.Typeface;
import android.net.Uri;
import android.support.v4.app.ActivityCompat;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.Toast;

public class Utils {

	public static String encodeTobase64(Bitmap image) {
		Bitmap immagex = image;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		immagex.compress(Bitmap.CompressFormat.JPEG, 100, baos);
		byte[] b = baos.toByteArray();
		String imageEncoded = Base64.encodeToString(b, Base64.DEFAULT);

		return imageEncoded;
	}

	@SuppressLint("UseValueOf")
	public static float LatLngDdistance(float lat_a, float lng_a, float lat_b, float lng_b) {
		double earthRadius = 3958.75;
		double latDiff = Math.toRadians(lat_b - lat_a);
		double lngDiff = Math.toRadians(lng_b - lng_a);
		double a = Math.sin(latDiff / 2) * Math.sin(latDiff / 2) +
				Math.cos(Math.toRadians(lat_a)) * Math.cos(Math.toRadians(lat_b)) *
						Math.sin(lngDiff / 2) * Math.sin(lngDiff / 2);
		double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
		double distance = earthRadius * c;

		int meterConversion = 1609;

		return new Float(distance * meterConversion).floatValue();
	}

	public static String cap1stChar(String userIdea) {
		String betterIdea = userIdea;
		if (userIdea.length() > 0) {
			String first = userIdea.substring(0, 1);
			betterIdea = userIdea.replaceFirst(first, first.toUpperCase());
		}
		return betterIdea;
	}

	public static Bitmap decodeBase64(String input) {
		byte[] decodedByte = Base64.decode(input, 0);
		return BitmapFactory.decodeByteArray(decodedByte, 0, decodedByte.length);
	}

	public static String md5(String input) {
		String result = input;
		if (input != null) {
			MessageDigest md;
			try {
				md = MessageDigest.getInstance("MD5");
				md.update(input.getBytes());
				BigInteger hash = new BigInteger(1, md.digest());
				result = hash.toString(16);
				if ((result.length() % 2) != 0) {
					result = "0" + result;
				}
				return result;
			} catch (NoSuchAlgorithmException e) {
				e.printStackTrace();
			} //or "SHA-1"

		}
		return "";
	}

	public static void overrideFonts(final Context context, final View v, String fuenteActual) {
		try {
			if (v instanceof ViewGroup) {
				ViewGroup vg = (ViewGroup) v;

				for (int i = 0; i < vg.getChildCount(); i++) {
					View child = vg.getChildAt(i);
					overrideFonts(context, child, fuenteActual);
				}

			} else if (v instanceof TextView) {
				((TextView) v).setTypeface(Typeface.createFromAsset(context.getAssets(), fuenteActual));
			}
		} catch (Exception e) {
		}
	}

	public static String performPostCall(String requestURL, HashMap<String, String> postDataParams) {

		URL url;
		String response = "";
		try {
			url = new URL(requestURL);

			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setReadTimeout(40000);
			conn.setConnectTimeout(8000);
			conn.setRequestMethod("POST");
			conn.setDoInput(true);
			conn.setDoOutput(true);


			OutputStream os = conn.getOutputStream();
			BufferedWriter writer = new BufferedWriter(
					new OutputStreamWriter(os, "UTF-8"));
			writer.write(getPostDataString(postDataParams));

			writer.flush();
			writer.close();
			os.close();

			conn.connect();

			int responseCode = conn.getResponseCode();

			if (responseCode == HttpsURLConnection.HTTP_OK || responseCode == 500) {
				String line;
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				while ((line = br.readLine()) != null) {
					response += line;
				}
			} else {
				response = null;

			}

			conn.disconnect();
			//os.close();
			//writer.close();
		} catch (Exception e) {
			e.printStackTrace();
		}


		return response;
	}


	public static void setClipboard(Context context, String text) {
		if (android.os.Build.VERSION.SDK_INT < android.os.Build.VERSION_CODES.HONEYCOMB) {
			android.text.ClipboardManager clipboard = (android.text.ClipboardManager) context.getSystemService(Context.CLIPBOARD_SERVICE);
			clipboard.setText(text);
		} else {
			android.content.ClipboardManager clipboard = (android.content.ClipboardManager) context.getSystemService(Context.CLIPBOARD_SERVICE);
			android.content.ClipData clip = android.content.ClipData.newPlainText("Texto Copiado", text);
			clipboard.setPrimaryClip(clip);
		}

		Toast.makeText(context, "Texto Copiado", Toast.LENGTH_SHORT).show();

	}

	private static String getPostDataString(HashMap<String, String> params) throws UnsupportedEncodingException {
		StringBuilder result = new StringBuilder();
		boolean first = true;
		for (Entry<String, String> entry : params.entrySet()) {
			if (first)
				first = false;
			else
				result.append("&");

			result.append(URLEncoder.encode(entry.getKey(), "UTF-8"));
			result.append("=");
			result.append(URLEncoder.encode(entry.getValue(), "UTF-8"));
		}

		return result.toString();
	}


	public static Bitmap RotateBitmap(Bitmap source, float angle) {
		Matrix matrix = new Matrix();
		matrix.postRotate(angle);
		return Bitmap.createBitmap(source, 0, 0, source.getWidth(), source.getHeight(), matrix, true);
	}

	public static String imprimirHash(Context c, String packageName) {

		// Add code to print out the key hash
		try {
			PackageInfo info = c.getPackageManager().getPackageInfo(
					packageName,
					PackageManager.GET_SIGNATURES);
			for (Signature signature : info.signatures) {
				MessageDigest md = MessageDigest.getInstance("SHA");
				md.update(signature.toByteArray());
				return Base64.encodeToString(md.digest(), Base64.DEFAULT);
			}
		} catch (NameNotFoundException e) {

		} catch (NoSuchAlgorithmException e) {

		}

		return null;

	}

	private static final NavigableMap<Long, String> suffixes = new TreeMap<Long, String>();

	static {
		suffixes.put(1_000L, "k");
		suffixes.put(1_000_000L, "M");
		suffixes.put(1_000_000_000L, "G");
		suffixes.put(1_000_000_000_000L, "T");
		suffixes.put(1_000_000_000_000_000L, "P");
		suffixes.put(1_000_000_000_000_000_000L, "E");
	}

	public static String formatLongToK(long value) {
		//Long.MIN_VALUE == -Long.MIN_VALUE so we need an adjustment here
		if (value == Long.MIN_VALUE) return formatLongToK(Long.MIN_VALUE + 1);
		if (value < 0) return "-" + formatLongToK(-value);
		if (value < 1000) return Long.toString(value); //deal with easy case

		Entry<Long, String> e = suffixes.floorEntry(value);
		Long divideBy = e.getKey();
		String suffix = e.getValue();

		long truncated = value / (divideBy / 10); //the number part of the output times 10
		boolean hasDecimal = truncated < 100 && (truncated / 10d) != (truncated / 10);
		return hasDecimal ? (truncated / 10d) + suffix : (truncated / 10) + suffix;
	}

	public static void abrirLink(Activity activity, String link) {
		try{
			Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(link));
			activity.startActivity(intent);
		}catch (Error e){

		}

	}

	public static void watchYoutubeVideo(Context c, String id) {
		try {
			Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse("vnd.youtube:" + id));
			c.startActivity(intent);
		} catch (ActivityNotFoundException ex) {
			Intent intent = new Intent(Intent.ACTION_VIEW,
					Uri.parse("http://www.youtube.com/watch?v=" + id));
			c.startActivity(intent);
		}
	}

	public static void abrirMapaYConducir(Context c, double latitud, double longitud, String nombre) {
		String uri = String.format(Locale.ENGLISH, "http://maps.google.com/maps?daddr=%f,%f (%s)", latitud, longitud, nombre);
		Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(uri));
		intent.setClassName("com.google.android.apps.maps", "com.google.android.maps.MapsActivity");
		c.startActivity(intent);
	}

	public static void llamarTelefono(Context c, String numero) {
		Intent intent = new Intent(Intent.ACTION_CALL, Uri.parse("tel:" + numero));
		if (ActivityCompat.checkSelfPermission(c, Manifest.permission.CALL_PHONE) == PackageManager.PERMISSION_GRANTED) {
			c.startActivity(intent);
		}
	}

	public static void enviarMail(Context c, String url) {
        Intent intent = new Intent(Intent.ACTION_SEND);

        String subject = "Consulta";
        String message = "";

        intent.setData(Uri.parse("mailto:"));

        intent.putExtra(Intent.EXTRA_EMAIL, new String[]{url});
        intent.putExtra(Intent.EXTRA_SUBJECT, subject);
        intent.putExtra(Intent.EXTRA_TEXT, message);

        intent.setType("text/plain");

        try {
            c.startActivity(Intent.createChooser(intent, "Enviar mail con:"));
        } catch (android.content.ActivityNotFoundException ex) {
            Toast.makeText(c, "No hay apps de envío de mails instaladas.", Toast.LENGTH_SHORT).show();
        }
    }

	public static void compartirLink(Context context, String link, String name,  String imagen){
		Intent imageIntent = new Intent(Intent.ACTION_SEND);
		Uri imageUri = Uri.parse(imagen);
		imageIntent.setType("text/*");
		//imageIntent.putExtra(Intent.EXTRA_STREAM, String.valueOf(imageUri));
		//imageIntent.putExtra(Intent.EXTRA_TITLE, link);
		String toShare = "Mira el local " + name + ". " + link + " Lo encontré en la app Avenida Cabildo. Descárgala acá: http//avenidacabildo.com.ar";
		imageIntent.putExtra(Intent.EXTRA_TEXT, toShare);
		context.startActivity(imageIntent);
	}

	public static void compartirLinkRedes(Context context, String link,  String imagen){
		Intent imageIntent = new Intent(Intent.ACTION_SEND);
		Uri imageUri = Uri.parse(imagen);
		imageIntent.setType("text/*");
		//imageIntent.putExtra(Intent.EXTRA_STREAM, String.valueOf(imageUri));
		//imageIntent.putExtra(Intent.EXTRA_TITLE, link);
		imageIntent.putExtra(Intent.EXTRA_TEXT, link);
		context.startActivity(imageIntent);
	}


	public static String obtenerHashFacebook(Context context){

		PackageInfo info;
		try {
			info = context.getPackageManager().getPackageInfo(context.getApplicationContext().getPackageName(), PackageManager.GET_SIGNATURES);
			for (Signature signature : info.signatures) {
				MessageDigest md;
				md = MessageDigest.getInstance("SHA");
				md.update(signature.toByteArray());
				String something = new String(Base64.encode(md.digest(), 0));
				//String something = new String(Base64.encodeBytes(md.digest()));
				Log.e("hash key", something);
				return something;

			}
		} catch (NameNotFoundException e1) {
			Log.e("name not found", e1.toString());
		} catch (NoSuchAlgorithmException e) {
			Log.e("no such an algorithm", e.toString());
		} catch (Exception e) {
			Log.e("exception", e.toString());
		}

		return null;

	}

}