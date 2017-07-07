package com.avenida_cabildo.avenida_cabildo.adapters;

import android.content.Context;
import android.view.View;
import android.widget.ImageView;

import com.bumptech.glide.Glide;
import com.avenida_cabildo.avenida_cabildo.R;
import com.avenida_cabildo.avenida_cabildo.models.Descuento;
import com.skocken.efficientadapter.lib.viewholder.EfficientViewHolder;

/**
 * Created by Alan on 20/01/2017.
 */

public class DescuentoViewHolder extends EfficientViewHolder<Descuento> {


    public DescuentoViewHolder(View itemView) {
        super(itemView);
    }

    @Override
    protected void updateView(Context context, Descuento descuento) {
        ImageView iv = findViewByIdEfficient(R.id.iv);
        Glide.with(getContext()).load(descuento.getPic()).into(iv);
    }
}
