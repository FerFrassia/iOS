package com.nanosoft.avenida_cabildo.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.DialogFragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.nanosoft.avenida_cabildo.R;
import com.nanosoft.avenida_cabildo.models.Local;
import com.nanosoft.avenida_cabildo.utils.Utils;

/**
 * Created by Alan on 27/01/2017.
 */

public class FragmentShare extends DialogFragment implements View.OnClickListener {

    private static final String KEY_LOCAL = "local";
    private Local local;

    public static FragmentShare newInstance(Local local) {
        Bundle args = new Bundle();
        args.putSerializable(KEY_LOCAL, local);

        FragmentShare fragment = new FragmentShare();
        fragment.setArguments(args);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        setHasOptionsMenu(false);

        getDialog().setTitle("Compartir");

        local = (Local) getArguments().getSerializable(KEY_LOCAL);

        View v = inflater.inflate(R.layout.dialog_share, null, false);

        v.findViewById(R.id.ll_facebook).setOnClickListener(this);
        v.findViewById(R.id.ll_instagram).setOnClickListener(this);
        v.findViewById(R.id.ll_copiar_enlace).setOnClickListener(this);

        if(local.getFacebook() == null)
            v.findViewById(R.id.ll_facebook).setVisibility(View.GONE);

        if(local.getInstagram() == null)
            v.findViewById(R.id.ll_instagram).setVisibility(View.GONE);

        if(local.getWeb() == null){
            v.findViewById(R.id.ll_copiar_enlace).setVisibility(View.GONE);
        }else{
            ((TextView) v.findViewById(R.id.tv_web)).setText("   " + local.getNombre());
        }

        return v;
    }


    @Override
    public void onClick(View view) {

        switch (view.getId()){
            case R.id.ll_facebook:
                if(local.getFacebook() != null)
                    Utils.compartirLinkRedes(getActivity(), local.getFacebook(), local.getImagen_logo());
                break;

            case R.id.ll_instagram:
                if(local.getInstagram() != null)
                    Utils.compartirLinkRedes(getActivity(), local.getInstagram(), local.getImagen_logo());
                break;

            case R.id.ll_copiar_enlace:

                if(local.getWeb() != null)
                    Utils.compartirLink(getActivity(), local.getWeb(), local.getNombre(), local.getImagen_logo());

                break;
        }

    }



}
