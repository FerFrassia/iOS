package com.FerFrassia.avenida_cabildo.adapters;

import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.FerFrassia.avenida_cabildo.R;
import com.FerFrassia.avenida_cabildo.models.Categoria;

import java.util.ArrayList;

/**
 * Created by Alan on 18/01/2017.
 */

public class CategoriasAdapter extends BaseAdapter {

    ArrayList<Categoria> categorias;
    Context context;

    public CategoriasAdapter(Context context, ArrayList<Categoria> categorias) {
        this.context = context;
        this.categorias = categorias;
    }

    @Override
    public int getCount() {
        return categorias.size();
    }

    @Override
    public Categoria getItem(int i) {
        return categorias.get(i);
    }

    @Override
    public long getItemId(int i) {
        return i;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {


        if (convertView == null) {
            convertView = LayoutInflater.from(context).inflate(R.layout.simple_spinner_item_2, null, false);
        }


        TextView label = (TextView) convertView.findViewById(R.id.tv_nombre_categoria);
        ImageView image = (ImageView) convertView.findViewById(R.id.iv_categorias);

        Categoria categoria = getItem(position);
        Glide.with(context).load(categoria.getImagen()).into(image);
        label.setText(categoria.getNombre());


        return convertView;
    }

    @Override
    public View getDropDownView(int position, View convertView, ViewGroup parent) {

        if (convertView == null) {
            convertView = LayoutInflater.from(context).inflate(R.layout.simple_spinner_item, null, false);
        }

        TextView label = (TextView) convertView.findViewById(R.id.tv_nombre_categoria);
        ImageView image = (ImageView) convertView.findViewById(R.id.iv_categorias);

        Categoria categoria = getItem(position);
        Glide.with(context).load(categoria.getImagen()).into(image);
        label.setText(categoria.getNombre());
        label.setTextColor(context.getResources().getColor(R.color.negro));
        image.setColorFilter(Color.argb(255, 0, 0, 0));
        return convertView;
    }




}
