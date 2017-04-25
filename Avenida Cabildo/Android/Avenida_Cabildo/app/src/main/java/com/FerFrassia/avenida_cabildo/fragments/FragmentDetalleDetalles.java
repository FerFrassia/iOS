package com.FerFrassia.avenida_cabildo.fragments;

import android.Manifest;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.ActivityCompat;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapView;
import com.google.android.gms.maps.MapsInitializer;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.model.BitmapDescriptor;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.FerFrassia.avenida_cabildo.R;
import com.FerFrassia.avenida_cabildo.models.Local;
import com.FerFrassia.avenida_cabildo.utils.Utils;

/**
 * Created by Alan on 11/01/2017.
 */
public class FragmentDetalleDetalles extends Fragment implements View.OnClickListener{


    private static final String KEY_LOCAL = "local";

    private Local local;

    private MapView mMapView;
    private GoogleMap googleMap;
    private Marker mMarker;

    public static FragmentDetalleDetalles newInstance(Local local) {
        Bundle args = new Bundle();
        args.putSerializable(KEY_LOCAL, local);
        FragmentDetalleDetalles fragment = new FragmentDetalleDetalles();
        fragment.setArguments(args);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {

        local = (Local) getArguments().getSerializable(KEY_LOCAL);

        View v = inflater.inflate(R.layout.f_local_detalle, null, false);

        v.findViewById(R.id.iv_facebook).setOnClickListener(this);
        v.findViewById(R.id.iv_instagram).setOnClickListener(this);

        v.findViewById(R.id.ll_email).setOnClickListener(this);
        v.findViewById(R.id.ll_horario).setOnClickListener(this);
        v.findViewById(R.id.ll_lugar).setOnClickListener(this);
        v.findViewById(R.id.ll_telefono).setOnClickListener(this);
        v.findViewById(R.id.ll_web).setOnClickListener(this);


        ((TextView) v.findViewById(R.id.tv_descripcion)).setText(local.getDetalle_texto());

        ((TextView) v.findViewById(R.id.tv_mail)).setText(local.getMail());
        ((TextView) v.findViewById(R.id.tv_horario)).setText(local.getHorarios());
        ((TextView) v.findViewById(R.id.tv_direccion)).setText(local.getDireccion());
        ((TextView) v.findViewById(R.id.tv_telefono)).setText(local.getTelefono());
        ((TextView) v.findViewById(R.id.tv_web)).setText(local.getWeb());

        mMapView = (MapView) v.findViewById(R.id.mapView);
        mMapView.onCreate(savedInstanceState);

        mMapView.onResume(); // needed to get the map to display immediately

        try {
            MapsInitializer.initialize(getActivity().getApplicationContext());
        } catch (Exception e) {
            e.printStackTrace();
        }

        mMapView.getMapAsync(new OnMapReadyCallback() {
            @Override
            public void onMapReady(GoogleMap mMap) {
                googleMap = mMap;

                // For showing a move to my location button
                if (!(ActivityCompat.checkSelfPermission(getActivity(), Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(getActivity(), Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED)) {
                    googleMap.setMyLocationEnabled(true);
                }

                try{
                    String[] latlngarr = local.getUbicacion().split(",");

                    double lat = Double.parseDouble(latlngarr[0]);
                    double lng = Double.parseDouble(latlngarr[1]);

                    // For dropping a marker at a point on the Map
                    LatLng coordinate = new LatLng(lat, lng);
                    BitmapDescriptor icon = BitmapDescriptorFactory.fromResource(R.drawable.logo);
                    mMarker = googleMap.addMarker(new MarkerOptions()
                            .position(coordinate)
                            .icon(BitmapDescriptorFactory.fromResource(R.drawable.ic_custom_marker))
                            .title(local.getNombre()));

                    CameraUpdate location = CameraUpdateFactory.newLatLngZoom(
                            coordinate, 16);

                    googleMap.animateCamera(location);

                }catch (Error e){

                }

            }
        });




        return v;
    }

    @Override
    public void onClick(View view) {

        switch (view.getId()) {

            case R.id.iv_facebook:

                Utils.abrirLink(getActivity(), local.getFacebook());
                break;

            case R.id.iv_instagram:
                Utils.abrirLink(getActivity(), local.getInstagram());
                break;

            case R.id.ll_email:
                Utils.enviarMail(getActivity(), local.getMail());
                break;

            case R.id.ll_horario:
                break;

            case R.id.ll_lugar:

                try{

                    String[] latlngarr = local.getUbicacion().split(",");

                    double lat = Double.parseDouble(latlngarr[0]);
                    double lng = Double.parseDouble(latlngarr[1]);

                    Utils.abrirMapaYConducir(getActivity(), lat, lng, local.getNombre());

                }catch (Error e){

                }


                break;

            case R.id.ll_telefono:
                Utils.llamarTelefono(getActivity(), local.getTelefono());
                break;

            case R.id.ll_web:
                Utils.abrirLink(getActivity(), local.getWeb());
                break;



        }
    }
}
