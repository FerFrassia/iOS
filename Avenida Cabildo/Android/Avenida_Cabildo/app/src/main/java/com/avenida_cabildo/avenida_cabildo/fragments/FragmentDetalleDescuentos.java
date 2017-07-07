package com.avenida_cabildo.avenida_cabildo.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.avenida_cabildo.avenida_cabildo.R;
import com.avenida_cabildo.avenida_cabildo.adapters.DescuentosViewHolder;
import com.avenida_cabildo.avenida_cabildo.models.Descuento;
import com.skocken.efficientadapter.lib.adapter.EfficientRecyclerAdapter;

import java.util.ArrayList;

/**
 * Created by Alan on 22/01/2017.
 */

public class FragmentDetalleDescuentos extends Fragment{

    EfficientRecyclerAdapter<Descuento> adapter;
    ArrayList<Descuento> descuentos;

    private static final String KEY_DESCUENTOS = "descuentos";

    public static FragmentDetalleDescuentos newInstance(ArrayList<Descuento> descuentos){

        FragmentDetalleDescuentos fragment = new FragmentDetalleDescuentos();

        Bundle bundle = new Bundle();
        bundle.putSerializable(KEY_DESCUENTOS, descuentos);
        fragment.setArguments(bundle);

        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        descuentos = (ArrayList<Descuento>) getArguments().getSerializable(KEY_DESCUENTOS);

        RecyclerView rv = new RecyclerView(getActivity());

        float scale = getResources().getDisplayMetrics().density;
        int dpAsPixels = (int) (16*scale + 0.5f);
        rv.setPadding(dpAsPixels,0,dpAsPixels,0);

        rv.setLayoutManager(new LinearLayoutManager(getActivity()));

        adapter = new EfficientRecyclerAdapter<Descuento>(R.layout.row_filtro_descuentos, DescuentosViewHolder.class, descuentos);


        rv.setAdapter(adapter);
        return rv;
    }

}
