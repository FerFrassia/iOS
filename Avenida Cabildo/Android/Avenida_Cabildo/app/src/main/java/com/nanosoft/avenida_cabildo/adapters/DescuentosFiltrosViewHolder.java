package com.nanosoft.avenida_cabildo.adapters;

import android.content.Context;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.nanosoft.avenida_cabildo.R;
import com.nanosoft.avenida_cabildo.models.Categoria;
import com.nanosoft.avenida_cabildo.models.Descuento;
import com.skocken.efficientadapter.lib.viewholder.EfficientViewHolder;

/**
 * Created by Alan on 18/01/2017.
 */

public class DescuentosFiltrosViewHolder extends EfficientViewHolder<Descuento>{

    public DescuentosFiltrosViewHolder(View itemView) {
        super(itemView);
    }

    @Override
    protected void updateView(Context context, Descuento descuento) {

        ImageView ivCheck = findViewByIdEfficient(R.id.iv_check);
        ImageView ivIcono = findViewByIdEfficient(R.id.iv_icono);
        TextView nombre = findViewByIdEfficient(R.id.tv_nombre);

        if(descuento.isFavorito()){
            nombre.setTextColor(getContext().getResources().getColor(R.color.colorAccent));
            ivCheck.setVisibility(View.VISIBLE);
        }else{
            ivCheck.setVisibility(View.GONE);
            nombre.setTextColor(getContext().getResources().getColor(R.color.gris));
        }

        nombre.setText(descuento.getNombre());
        Glide.with(getContext()).load(descuento.getPic()).into(ivIcono);
    }

}
