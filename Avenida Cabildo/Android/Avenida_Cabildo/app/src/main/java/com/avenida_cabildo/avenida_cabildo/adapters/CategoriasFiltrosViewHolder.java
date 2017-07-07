package com.avenida_cabildo.avenida_cabildo.adapters;

import android.content.Context;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.avenida_cabildo.avenida_cabildo.R;
import com.avenida_cabildo.avenida_cabildo.models.Categoria;
import com.skocken.efficientadapter.lib.viewholder.EfficientViewHolder;

/**
 * Created by Alan on 18/01/2017.
 */

public class CategoriasFiltrosViewHolder extends EfficientViewHolder<Categoria>{

    public CategoriasFiltrosViewHolder(View itemView) {
        super(itemView);
    }

    @Override
    protected void updateView(Context context, Categoria categoria) {

        ImageView ivCheck = findViewByIdEfficient(R.id.iv_check);
        ImageView ivCategoria = findViewByIdEfficient(R.id.iv_icono);
        TextView nombre = findViewByIdEfficient(R.id.tv_nombre);

        if(categoria.isFavorita()){
            ivCheck.setVisibility(View.VISIBLE);
            nombre.setTextColor(getContext().getResources().getColor(R.color.colorAccent));
            ivCategoria.setColorFilter(getResources().getColor(R.color.colorAccent));
        }else{
            ivCheck.setVisibility(View.GONE);
            nombre.setTextColor(getContext().getResources().getColor(R.color.gris));
            ivCategoria.setColorFilter(getResources().getColor(R.color.gris));
        }

        nombre.setText(categoria.getNombre());
        Glide.with(getContext()).load(categoria.getImagen()).into(ivCategoria);
    }

}
