import java.io.BufferedReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.io.InputStreamReader;

import java.util.ArrayList;
import java.util.Iterator;

String urlgetrest="https://apex.oracle.com/pls/apex/ace2g3/sensores/ambientefecha/";
ArrayList<Lectura> lecturas= new ArrayList<Lectura>();

void setup() {
  fullScreen();
  noStroke();
  fill(0);
}

void draw() {
  //background(204);
  if (mousePressed) {
    if (mouseX < width/2) {
      
      rect(0, 0, width/2, height); // Left
      restCargarLecturas("20190222");
      
      int x=0,y=5;
      
      fill(0, 102, 153);
      for(Lectura lec: lecturas){
        textSize(8);
        text(lec.getFechaCompletaString(), x+5, y);        
        y+=5;
      }
      fill(50);

    } else {
      rect(width/2, 0, width/2, height); // Right
    }
  }
}


    /*
    * Carga las lecturas desde el servicio rest para una fecha dada
    * @param fecha String conteniendo la fecha que se desea cargar en formato yyyymmdd (<año><mes><dia>)
    */
    void restCargarLecturas(String fecha) {
        HttpURLConnection conn = null;
        JSONObject response=null;
        JSONArray lecturasRecibidas=null;
        try {

            URL url = new URL(urlgetrest+fecha);
            conn = (HttpURLConnection) url.openConnection();

            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuffer data = new StringBuffer(5120);
            String tmpdata = "";
            while ((tmpdata = reader.readLine()) != null) {

                data.append(tmpdata); //.append("\n");

            }

            //println(data.toString());
            response = parseJSONObject(data.toString());
            lecturasRecibidas = response.getJSONArray("items");
            reader.close();
        } catch (Exception e) {
            e.printStackTrace();

        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
        
        //Cantidad de items recibidos
        //println("Tamaño" + lecturasRecibidas.size());

        lecturas.clear();
        if(lecturasRecibidas != null){
          for (int i = 0; i < lecturasRecibidas.size(); i++) {
              JSONObject restLectura = lecturasRecibidas.getJSONObject(i);
              Lectura temp= new Lectura(restLectura.getDouble("latitud"), restLectura.getDouble("longitud"), restLectura.getInt("mq7"), restLectura.getInt("mq135"), restLectura.getInt("guvas12sduv"), restLectura.getString("fecha"), restLectura.getString("hora"));
              lecturas.add(temp);            
          }
        }

    }
