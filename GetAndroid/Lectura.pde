
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Universidad de San Carlos de Guatemala Facultad de Ingenieria
 *
 * @author Sergio Fernando Giovani Morales Diaz
 * @email envidiom@gmail.com
 * @carnet 9616709
 */
public class Lectura {

    private double latitud;
    private double longitud;
    private int mq7;
    private int mq135;
    private int guvas12sduv;
    private Date fecha;
    private int hora;
    private double horaDouble;
    ///////////////////////////////////////7
    SimpleDateFormat outFormat;

    /**
     * Constructor del objeto Lectura
     * @param latitud double conteniendo la latitud
     * @param longitud double conteniendo la longitud
     * @param mq7 int conteniendo la lectura del sensor mq7
     * @param mq135 int conteniendo la lectura del sensor mq135
     * @param guvas12sduv int conteniendo la lectura del sensor guvas12sduv
     * @param fecha String conteniendo la fecha con el formato dd/MM/yyyy
     * @param hora String conteniendo la fecha con el formato HH:mm:ss
     */
    public Lectura(double latitud, double longitud, int mq7, int mq135, int guvas12sduv, String fecha, String hora) {
        SimpleDateFormat inFormatFecha = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        SimpleDateFormat inFormatHora = new SimpleDateFormat("HH");
        SimpleDateFormat inFormatMin = new SimpleDateFormat("mm");
        SimpleDateFormat inFormatSec = new SimpleDateFormat("ss");

        this.outFormat = new SimpleDateFormat("dd/MM/yyyy");
        this.latitud = latitud;
        this.longitud = longitud;
        this.mq7 = mq7;
        this.mq135 = mq135;
        this.guvas12sduv = guvas12sduv;

        try {
            this.fecha = inFormatFecha.parse(fecha + " " + hora);
            this.horaDouble = Double.parseDouble(inFormatHora.format(this.fecha))
                    + Double.parseDouble(inFormatMin.format(this.fecha)) / 60
                    + Double.parseDouble(inFormatSec.format(this.fecha)) / 3600;
        } catch (ParseException ex) {
            Logger.getLogger(Lectura.class.getName()).log(Level.SEVERE, null, ex);
        }

        this.hora = Integer.parseInt(inFormatHora.format(this.fecha));

    }

    /**
     *
     * @return double con el valor de latitud
     */
    public double getLatitud() {
        return latitud;
    }

    /**
     *
     * @return double con el valor de longitud
     */
    public double getLongitud() {
        return longitud;
    }

    /**
     *
     * @return int con el valor del sensor mq7
     */
    public int getMq7() {
        return mq7;
    }

    /**
     *
     * @return int con el valor del sensor mq135
     */
    public int getMq135() {
        return mq135;
    }

    /**
     *
     * @return int con el valor del sensor guvas12sduv
     */
    public int getGuvas12sduv() {
        return guvas12sduv;
    }

    /**
     * Retorna el valor de la fecha completa incluyendo la hora
     * @return Date con el valor completo de la fecha y hora
     */
    public Date getFechaCompleta() {
        return fecha;
    }

    /**
     * Devuelve la hora en formato entero 1..24 de la lectura
     * @return int con el número de hora de la lectura
     */
    public int getHora() {
        return hora;
    }

    /**
     * Devuelve la fecha como texto en el formato dd/MM/yyyy
     * @return STring con la fecha en formato dd/MM/yyyy
     */
    public String getFechaString() {
        return outFormat.format(fecha);
    }

    /**
     * Devuelve el valor de la hora mas la fraccion de minutos y segundos
     * @return double con la representacion en double de la hora minutos y segundos
     */
    public double getHoraDouble() {
        return horaDouble;
    }
    
    /**
     * Funcion que devuelve la fecha completa con hora como texto
     * @return String devuelve la fecha completa incluyendo fecha y hora
     */
    public String getFechaCompletaString(){
        SimpleDateFormat outFormatFecha = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        return outFormatFecha.format(fecha);
    }
}
