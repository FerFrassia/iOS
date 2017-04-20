package com.FerFrassia.avenida_cabildo.adapters;

import android.content.Context;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.FerFrassia.avenida_cabildo.R;
import com.FerFrassia.avenida_cabildo.models.Descuento;
import com.skocken.efficientadapter.lib.viewholder.EfficientViewHolder;

/**
 * Created by Alan on 18/01/2017.
 */

public class DescuentosViewHolder extends EfficientViewHolder<Descuento>{

    public DescuentosViewHolder(View itemView) {
        super(itemView);
    }

    @Override
    protected void updateView(Context context, Descuento descuento) {

        ImageView ivCheck = findViewByIdEfficient(R.id.iv_check);
        ImageView ivIcono = findViewByIdEfficient(R.id.iv_icono);
        TextView nombre = findViewByIdEfficient(R.id.tv_nombre);

        ivCheck.setVisibility(View.GONE);
        nombre.setTextColor(getContext().getResources().getColor(R.color.colorAccent));
        nombre.setText(descuento.getNombre());
        Glide.with(getContext()).load(descuento.getPic()).into(ivIcono);
    }

}
