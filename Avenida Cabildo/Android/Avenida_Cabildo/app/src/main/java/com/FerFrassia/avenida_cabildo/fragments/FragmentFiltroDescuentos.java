package com.FerFrassia.avenida_cabildo.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.FerFrassia.avenida_cabildo.ActivityMain;
import com.FerFrassia.avenida_cabildo.adapters.DescuentosFiltrosViewHolder;
import com.FerFrassia.avenida_cabildo.models.Descuento;
import com.skocken.efficientadapter.lib.adapter.EfficientAdapter;
import com.skocken.efficientadapter.lib.adapter.EfficientRecyclerAdapter;
import com.FerFrassia.avenida_cabildo.R;

/**
 * Created by Alan on 22/01/2017.
 */

public class FragmentFiltroDescuentos extends Fragment{

    EfficientRecyclerAdapter<Descuento> adapter;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        RecyclerView rv = new RecyclerView(getActivity());

        float scale = getResources().getDisplayMetrics().density;
        int dpAsPixels = (int) (16*scale + 0.5f);
        rv.setPadding(dpAsPixels,0,dpAsPixels,0);

        rv.setLayoutManager(new LinearLayoutManager(getActivity()));

        adapter = new EfficientRecyclerAdapter<Descuento>(R.layout.row_filtro_descuentos, DescuentosFiltrosViewHolder.class, ActivityMain.descuentos);
        adapter.setOnItemClickListener(new EfficientAdapter.OnItemClickListener<Descuento>() {
            @Override
            public void onItemClick(EfficientAdapter<Descuento> adapter, View view, Descuento object, int position) {
                adapter.get(position).setFavorito(!object.isFavorito());
                adapter.notifyItemChanged(position);
            }
        });

        rv.setAdapter(adapter);
        return rv;
    }

    public void resetear() {
        if(adapter != null){
            for(int i = 0; i < adapter.size(); i++){
                adapter.get(i).setFavorito(true);
            }
            adapter.notifyDataSetChanged();
        }
    }
}
