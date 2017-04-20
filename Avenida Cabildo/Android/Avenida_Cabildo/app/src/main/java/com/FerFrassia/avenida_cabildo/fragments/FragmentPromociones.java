package com.FerFrassia.avenida_cabildo.fragments;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.support.v4.view.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.maps.CameraUpdate;
import com.google.android.gms.maps.CameraUpdateFactory;
import com.google.android.gms.maps.GoogleMap;
import com.google.android.gms.maps.MapView;
import com.google.android.gms.maps.MapsInitializer;
import com.google.android.gms.maps.OnMapReadyCallback;
import com.google.android.gms.maps.model.BitmapDescriptor;
import com.google.android.gms.maps.model.BitmapDescriptorFactory;
import com.google.android.gms.maps.model.CameraPosition;
import com.google.android.gms.maps.model.LatLng;
import com.google.android.gms.maps.model.Marker;
import com.google.android.gms.maps.model.MarkerOptions;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.Query;
import com.google.firebase.database.ValueEventListener;
import com.FerFrassia.avenida_cabildo.ActivityMain;
import com.FerFrassia.avenida_cabildo.adapters.CategoriasAdapter;
import com.FerFrassia.avenida_cabildo.adapters.LocalViewHolder;
import com.FerFrassia.avenida_cabildo.R;
import com.FerFrassia.avenida_cabildo.models.Local;
import com.FerFrassia.avenida_cabildo.utils.FirebaseReferences;
import com.skocken.efficientadapter.lib.adapter.EfficientAdapter;
import com.skocken.efficientadapter.lib.adapter.EfficientPagerAdapter;

import java.util.ArrayList;

/**
 * Created by Alan on 11/01/2017.
 */
public class FragmentPromociones extends Fragment {


    MapView mMapView;
    private GoogleMap googleMap;
    private Spinner spCategorias;
    private ArrayList<Local> locales = new ArrayList<>();
    private static FirebaseDatabase database;

    private EfficientPagerAdapter<Local> adapter;

    private ViewPager pager;
    private Marker mMarker;

    private Fragment prevFragment;

    private TextView tvSinItems;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        final View rootView = inflater.inflate(R.layout.f_promociones, null, false);

        mMapView = (MapView) rootView.findViewById(R.id.mapView);
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

                // For dropping a marker at a point on the Map
                LatLng sydney = new LatLng(-34.5584872,-58.4593467);
                BitmapDescriptor icon = BitmapDescriptorFactory.fromResource(R.drawable.logo);
                mMarker = googleMap.addMarker(new MarkerOptions()
                        .position(sydney)
                        .title("Marker Title")
                        .icon(BitmapDescriptorFactory.fromResource(R.drawable.ic_custom_marker))
                        .snippet("Marker Description"));

                // For zooming automatically to the location of the marker
                CameraPosition cameraPosition = new CameraPosition.Builder().target(sydney).zoom(16).build();
                googleMap.animateCamera(CameraUpdateFactory.newCameraPosition(cameraPosition));
            }
        });

        //Cargar las categorias.

        tvSinItems = (TextView) rootView.findViewById(R.id.tv_sin_items);

        pager = (ViewPager) rootView.findViewById(R.id.pager);

        // Disable clip to padding
        pager.setClipToPadding(false);
        // set padding manually, the more you set the padding the more you see of prev & next page
        pager.setPadding(40, 0, 40, 0);
        // sets a margin b/w individual pages to ensure that there is a gap b/w them
        pager.setPageMargin(8);

        pager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

            }

            @Override
            public void onPageSelected(int position) {

                if(googleMap != null){

                    try {
                        Local local = locales.get(position);
                        String[] latlngarr = local.getUbicacion().split(",");

                        double lat = Double.parseDouble(latlngarr[0]);
                        double lng = Double.parseDouble(latlngarr[1]);

                        LatLng coordinate = new LatLng(lat, lng); //Store these lat lng values somewhere. These should be constant.
                        CameraUpdate location = CameraUpdateFactory.newLatLngZoom(
                                coordinate, 18);

                        mMarker.setPosition(coordinate);

                        googleMap.animateCamera(location);
                    }catch (Error e){

                    }

                }
            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });

        database = FirebaseDatabase.getInstance();

        spCategorias = (Spinner) rootView.findViewById(R.id.sp_categorias);
        spCategorias.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {

                DatabaseReference ref = database.getReference(FirebaseReferences.REF_LOCALES);

                String nombreCategoria = ActivityMain.categorias.get(spCategorias.getSelectedItemPosition()).getNombre();

                Query llamada;

                if(!nombreCategoria.equals("Todos"))
                    llamada = ref.orderByChild("categoria").equalTo(nombreCategoria);
                else
                    llamada = ref.orderByChild("en promocion").equalTo(1);

                llamada.addListenerForSingleValueEvent(
                        new ValueEventListener() {
                            @Override
                            public void onDataChange(DataSnapshot dataSnapshot) {

                                locales.clear();

                                for (DataSnapshot snapshot: dataSnapshot.getChildren()) {
                                    Local local = Local.snapshotToLocal(snapshot);

                                    if(snapshot.child("en promocion").getValue(Long.class) == 1)
                                        locales.add(local);
                                }

                                if(locales.size() > 0){
                                    adapter = new EfficientPagerAdapter<Local>(R.layout.row_promocion, LocalViewHolder.class, locales);

                                    adapter.setOnItemClickListener(new EfficientAdapter.OnItemClickListener<Local>() {
                                        @Override
                                        public void onItemClick(EfficientAdapter<Local> adapter, View view, Local object, int position) {
                                            Toast.makeText(getActivity(), object.getNombre() + " - " + position, Toast.LENGTH_SHORT).show();
                                        }
                                    });

                                    pager.setAdapter(adapter);

                                    tvSinItems.setVisibility(View.GONE);


                                }else{
                                    pager.setAdapter(null);
                                    tvSinItems.setVisibility(View.VISIBLE);
                                }


                            }

                            @Override
                            public void onCancelled(DatabaseError databaseError) {

                            }
                        });

            }

            @Override
            public void onNothingSelected(AdapterView<?> adapterView) {

            }
        });

        CategoriasAdapter adaptador = new CategoriasAdapter(getActivity(), ActivityMain.categorias);
        spCategorias.setAdapter(adaptador);

        return rootView;
    }

    @Override
    public void onResume() {
        super.onResume();
        mMapView.onResume();
    }

    @Override
    public void onPause() {
        super.onPause();
        mMapView.onPause();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        mMapView.onDestroy();
    }

    @Override
    public void onLowMemory() {
        super.onLowMemory();
        mMapView.onLowMemory();
    }

}
