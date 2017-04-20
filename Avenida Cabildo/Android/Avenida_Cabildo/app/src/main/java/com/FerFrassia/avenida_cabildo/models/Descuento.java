package com.FerFrassia.avenida_cabildo.models;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by Alan on 19/01/2017.
 */

public class Descuento implements Serializable {

    private static ArrayList<Descuento> descuentos = new ArrayList<>();

    private String nombre;
    private String pic;
    private boolean favorito;

    public Descuento(String nombre, String pic){
        this.nombre = nombre;
        this.pic = pic;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }

    public boolean isFavorito() {
        return favorito;
    }

    public void setFavorito(boolean favorito) {
        this.favorito = favorito;
    }
}
