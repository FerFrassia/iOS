package com.avenida_cabildo.avenida_cabildo.models;

import java.io.Serializable;

/**
 * Created by Alan on 26/01/2017.
 */

public class DiaLaboral implements Serializable{
    private int dia;
    private int horarioApertura;
    private int horarioCierre;

    public int getDia() {
        return dia;
    }

    public void setDia(int dia) {
        this.dia = dia;
    }

    public int getHorarioApertura() {
        return horarioApertura;
    }

    public void setHorarioApertura(int horarioApertura) {
        this.horarioApertura = horarioApertura;
    }

    public int getHorarioCierre() {
        return horarioCierre;
    }

    public void setHorarioCierre(int horarioCierre) {
        this.horarioCierre = horarioCierre;
    }
}
