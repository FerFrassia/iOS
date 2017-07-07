package com.avenida_cabildo.avenida_cabildo.adapters;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.TextView;

import com.avenida_cabildo.avenida_cabildo.R;
import com.avenida_cabildo.avenida_cabildo.models.Local;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Alan on 26/01/2017.
 */

public class LocalesAutoCompleteAdapter extends BaseAdapter implements Filterable {

    private static final int MAX_RESULTS = 10;
    private Context mContext;
    private List<Local> resultList = new ArrayList<Local>();

    public LocalesAutoCompleteAdapter(Context context) {
        mContext = context;
    }

    @Override
    public int getCount() {
        return resultList.size();
    }

    @Override
    public Local getItem(int index) {
        return resultList.get(index);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        if (convertView == null) {

            LayoutInflater inflater = (LayoutInflater) mContext
                    .getSystemService(Context.LAYOUT_INFLATER_SERVICE);

            convertView = inflater.inflate(R.layout.simple_spinner_item_2, parent, false);
        }

        ((TextView) convertView.findViewById(R.id.tv_nombre_categoria)).setText(getItem(position).getNombre());

        //((TextView) convertView.findViewById(R.id.text2)).setText(getItem(position).getAuthor());

        return convertView;
    }

    @Override
    public Filter getFilter() {

        Filter filter = new Filter() {
            @Override
            protected FilterResults performFiltering(CharSequence constraint) {
                FilterResults filterResults = new FilterResults();
                if (constraint != null) {

                    List<Local> locals = null;//findLocales(mContext, constraint.toString());

                    // Assign the data to the FilterResults
                    filterResults.values = locals;
                    filterResults.count = locals.size();
                }
                return filterResults;
            }

            @Override
            protected void publishResults(CharSequence constraint, FilterResults results) {
                if (results != null && results.count > 0) {
                    resultList = (List<Local>) results.values;
                    notifyDataSetChanged();
                } else {
                    notifyDataSetInvalidated();
                }
            }};

        return filter;
    }

    /**
     * Returns a search result for the given book title.
     */
    /*private List<Local> findLocales(Context context, String localTitle) {
        // GoogleBooksProtocol is a wrapper for the Google Books API

        ActivityMain.db.getReference(FirebaseReferences.REF_LOCALES)
                .child("nombre_simple")
                .startAt(localTitle)
                .limitToFirst(10)

                .addListenerForSingleValueEvent(new ValueEventListener() {
                    @Override
                    public void onDataChange(DataSnapshot dataSnapshot) {

                        GoogleBooksProtocol protocol = new GoogleBooksProtocol(context, MAX_RESULTS);
                        return protocol.findBooks(bookTitle);

                    }

                    @Override
                    public void onCancelled(DatabaseError databaseError) {

                    }
                });

        return null;

    }*/
}
