package com.FerFrassia.avenida_cabildo.models;

import com.google.firebase.database.DataSnapshot;
import com.FerFrassia.avenida_cabildo.ActivityMain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

/**
 * Created by Alan on 18/01/2017.
 */

public class Local implements Serializable {

    public static final int VISIBILIDAD_ALTA = 1;
    public static final int VISIBILIDAD_MEDIA = 2;
    public static final int VISIBILIDAD_BAJA = 3;


    private String nombre;
    private String categoria;
    private String detalle_texto;
    private String direccion;
    private String efectivo;
    private String facebook;
    private String horarios;
    private String imagen_fondo;
    private String imagen_logo;
    private String instagram;
    private String mail;
    private String telefono;
    private String ubicacion;
    private long visibilidad;
    private String web;
    private boolean favorito;
    private ArrayList<Descuento> descuentoss = new ArrayList<>();
    private ArrayList<DiaLaboral> diasLaborales = new ArrayList<>();

    @Override
    public String toString() {
        return nombre;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public String getDetalle_texto() {
        return detalle_texto;
    }

    public void setDetalle_texto(String detalle_texto) {
        this.detalle_texto = detalle_texto;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getEfectivo() {
        return efectivo;
    }

    public void setEfectivo(String efectivo) {
        this.efectivo = efectivo;
    }

    public String getFacebook() {
        return facebook;
    }

    public void setFacebook(String facebook) {
        this.facebook = facebook;
    }

    public String getHorarios() {
        return horarios;
    }

    public void setHorarios(String horarios) {
        this.horarios = horarios;
    }

    public String getImagen_fondo() {
        return imagen_fondo;
    }

    public void setImagen_fondo(String imagen_fondo) {
        this.imagen_fondo = imagen_fondo;
    }

    public String getImagen_logo() {
        return imagen_logo;
    }

    public void setImagen_logo(String imagen_logo) {
        this.imagen_logo = imagen_logo;
    }

    public String getInstagram() {
        return instagram;
    }

    public void setInstagram(String instagram) {
        this.instagram = instagram;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getUbicacion() {
        return ubicacion;
    }

    public void setUbicacion(String ubicacion) {
        this.ubicacion = ubicacion;
    }

    public long getVisibilidad() {
        return visibilidad;
    }

    public void setVisibilidad(long visibilidad) {
        this.visibilidad = visibilidad;
    }

    public String getWeb() {
        return web;
    }

    public void setWeb(String web) {
        this.web = web;
    }

    public boolean isFavorito() {
        return favorito;
    }

    public void setFavorito(boolean favorito) {
        this.favorito = favorito;
    }

    public ArrayList<Descuento> getDescuentoss() {
        return descuentoss;
    }

    public void setDescuentoss(ArrayList<Descuento> descuentos) {
        this.descuentoss = descuentos;
    }


    public ArrayList<DiaLaboral> getDiasLaborales() {
        return diasLaborales;
    }

    public void setDiasLaborales(ArrayList<DiaLaboral> dias) {
        this.diasLaborales = dias;
    }


    public void sincronizarDescuentos(ArrayList<String> list){

        descuentoss = new ArrayList<>();

        for(int i = 0; i < list.size(); i++){
            for (int j = 0; j < ActivityMain.descuentos.size(); j++){
                if(ActivityMain.descuentos.get(j).getNombre().equals(list.get(i))){
                    descuentoss.add(ActivityMain.descuentos.get(j));
                }
            }
        }
    }

    public boolean visibleEnFiltro(){
        return categoriaFiltrada() && descuentoFiltrado();
    }


    private boolean categoriaFiltrada(){
        for(int i = 0; i < ActivityMain.categorias.size(); i++){
            if(categoria.equals(ActivityMain.categorias.get(i).getNombre()) && ActivityMain.categorias.get(i).isFavorita() )
                return true;
        }
        return  false;
    }

    private boolean descuentoFiltrado(){
        if(descuentoss != null && ActivityMain.descuentos != null) {
            if (descuentoss.size() == 0) {
                return true;
            } else {
                for (int i = 0; i < descuentoss.size(); i++) {
                    for (int j = 0; j < ActivityMain.descuentos.size(); j++) {
                        if (ActivityMain.descuentos.get(j).getNombre().equals(descuentoss.get(i).getNombre()) && ActivityMain.descuentos.get(j).isFavorito())
                            return true;
                    }
                }
                return false;
            }
        }
        return false;
    }

    public boolean isAbierto(){

        Date date = new Date();

        for(int i = 0; i < diasLaborales.size();i++){
            if(diasLaborales.get(i).getDia() == date.getDay()
                    && date.getHours() >= diasLaborales.get(i).getHorarioApertura()
                    && date.getHours() < diasLaborales.get(i).getHorarioCierre()){

                return true;
            }
        }

        return false;
    }

    public static Local snapshotToLocal(DataSnapshot snapshot){


        Local local = snapshot.getValue(Local.class);
        local.setNombre(snapshot.getKey());

        local.setDetalle_texto(snapshot.child("detalle texto").getValue(String.class));
        local.setImagen_fondo(snapshot.child("imagen fondo").getValue(String.class));
        local.setImagen_logo(snapshot.child("imagen logo").getValue(String.class));

        local.setFavorito(ActivityMain.esFavorito(local));

        //Sincronizar Descuentos
        ArrayList<String> descuentos = new ArrayList<String>();
        for(DataSnapshot nombreDescuento: snapshot.child("descuentos").getChildren()){
            descuentos.add(nombreDescuento.getValue(String.class));
        }

        ArrayList<DiaLaboral> diasLaborales = new ArrayList<>();

        for(DataSnapshot diaSnap: snapshot.child("horarios para filtro").getChildren()){
            DiaLaboral diaLaboral = new DiaLaboral();
            int intDia = DiaStringToInt(diaSnap.getKey());

            if(intDia != -1){
                diaLaboral.setDia(intDia);
                diaLaboral.setHorarioApertura(diaSnap.child("abre").getValue(Integer.class));
                diaLaboral.setHorarioCierre(diaSnap.child("cierra").getValue(Integer.class));
                diasLaborales.add(diaLaboral);
            }
        }

        local.setDiasLaborales(diasLaborales);
        local.sincronizarDescuentos(descuentos);

        return local;

    }


    private static int DiaStringToInt(String dia){

        switch (dia){

            case "lunes":
                return 1;

            case "martes":
                return 2;

            case "miercoles":
                return 3;

            case "jueves":
                return 4;

            case "viernes":
                return 5;

            case "sabado":
                return 6;

            case "domingo":
                return 7;

        }

        return -1;


    }


}
